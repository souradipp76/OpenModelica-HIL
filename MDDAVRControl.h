#include <string.h>
#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include <stdint.h>

#include "PIDAutotuner.h"

#ifndef PID_H_
#define PID_H_


//Defineparameter
#define MAX 5 //Saturation
#define MIN 0

float Kp;

static inline float tuneController(float setpoint,float feedback)
{
	PIDAutotuner P_Arduino;
	P_Arduino.setTargetInputValue(setpoint);
	P_Arduino.loopInterval(1000);
	P_Arduino.setZNMode(0);
	P_Arduino.setOutputRange(0,1023);

	P_Arduino.startTuningLoop();
	while(!P_Arduino.isFinished())
		P_Arduino.tunePID(feedback);

	return P_Arduino.getKp();
}

static inline float control(float setpoint,float feedback)
{
	static float pre_error= 0;
	float error;
	float output;
	//CaculateP,I,D
	Kp=tuneController(setpoint,feedback);
	error = setpoint -feedback;
	output=Kp*error;

	//Saturation Filter
	if(output> MAX)
	{
		output= MAX;
	}
	elseif(output< MIN)
	{
		output= MIN;
	}
	//Update error
	pre_error= error;
	return output;
}

#endif /*PID_H_*/