/*
 * Copyright (C) 2008 The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include <fcntl.h>
#include <errno.h>
#include <math.h>
#include <poll.h>
#include <unistd.h>
#include <dirent.h>
#include <stdlib.h>
#include <sys/select.h>

#include <cutils/log.h>

#include "LightSensor.h"

// lightsensor_file_illuminance is current value
// lightsensor_file_cmd powers the sensor on but reading file state does that too
#define LIGHT_SENSOR_FILE "/sys/class/lightsensor/switch_cmd/lightsensor_file_state"

#if 0
this is how classy the lightsensor code in kernel is
so it takes 180ms to read effin sensor

	if((bh1721_write_command(chip->client, &POWER_ON))>0)
		light_enable = ON;
	bh1721_write_command(chip->client, &H_RESOLUTION_2);

	/* Maximum measurement time */
	msleep(180);
	bh1721_read_value(chip->client, chip->illuminance_data);
	if((bh1721_write_command(chip->client, &POWER_DOWN))>0)
		light_enable = OFF;
	result = chip->illuminance_data[0] << 8 | chip->illuminance_data[1];
	result = (result*10)/12;
	
	/* apply hysteresis */
	result = get_next_level(result);
	return sprintf(buf, "%d\n", result);
#endif



/*****************************************************************************/

LightSensor::LightSensor()
    : SensorBase(LIGHT_SENSOR_FILE, NULL),
      mEnabled(0),
      mExtraDelay(0),
      mHasPendingEvent(false)
{
    mPendingEvent.version = sizeof(sensors_event_t);
    mPendingEvent.sensor = ID_L;
    mPendingEvent.type = SENSOR_TYPE_LIGHT;
    memset(mPendingEvent.data, 0, sizeof(mPendingEvent.data));

    open_device();

    enable(0, 1);
}

LightSensor::~LightSensor() {
}

int LightSensor::setInitialState() {
    mPendingEvent.light = read();
    mPendingEvent.timestamp = getTimestamp();
    mHasPendingEvent = true;
    return 0;
}

static void *jumper(void *arg)
{
    ((LightSensor *)arg)->readLoop();
    return NULL;
}

int LightSensor::enable(int32_t, int en) {
    int nNewState = en ? 1 : 0;
    int err = 0;
    if (nNewState != mEnabled) {
        if (nNewState)
        {
            setInitialState();
            bReaderRunning = true;
            pthread_create(&mReaderThread, NULL, jumper, (void *)this);
        }
        else
        {
            bReaderRunning = false;
            pthread_join(mReaderThread, NULL);
        }
        mEnabled = nNewState;
    }
    return err;
}

bool LightSensor::hasPendingEvents() const {
    return mHasPendingEvent;
}

int LightSensor::readEvents(sensors_event_t* data, int count)
{
    if (count < 1)
        return -EINVAL;

    if (mHasPendingEvent) {
        *data = mPendingEvent;
        mHasPendingEvent = false;
        return mEnabled ? 1 : 0;
    }

    return 0;
}

float
LightSensor::read(void)
{
    close(dev_fd);
    dev_fd = open(dev_name, O_RDONLY);
    char buf[8];
    ssize_t r;
    r = ::read(dev_fd, (void *)buf, 7); // this probably takes 180ms
    buf[r] = 0;
    unsigned int l;
    l = strtoul(buf, NULL, 10);
    return (float)l;
}

void
LightSensor::readLoop(void)
{
    while (bReaderRunning) {
        // so maybe there is some race here, who cares
        mPendingEvent.light = read();
        mPendingEvent.timestamp = getTimestamp();
        mHasPendingEvent = true;
        usleep(mExtraDelay);
    }
}

int
LightSensor::setDelay(int32_t handle, int64_t ns)
{
    ns /= 1000;
    if (ns > 180000)
    {
        mExtraDelay = (unsigned int)ns - 180000;
    }
    return 0;
}


