#include <string.h>
#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include <stdint.h>

#define Kp 9.0
#define Ki 1.8
#define Kd 0.45

float Error = 0,Integral = 0;


float control(float setpoint,float feedback)
{
	float lastError, Derivative, controlValue, processValue; //variable for PID with default values
	processValue = feedback;
    lastError = Error;
    Error = setpoint - processValue;
    Integral = Integral + Error;
    Derivative = Error - lastError;
    controlValue = (Kp * Error) + (Ki * Integral) + (Kd * Derivative); //simple PID algorithm

	return controlValue;
}
