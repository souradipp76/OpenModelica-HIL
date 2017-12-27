#include <string.h>
#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include <stdint.h>

float Kp = 9.0, Ki = 1.8, Kd = 0.45, Error = 0.0, lastError, Integral = 0.0, Derivative, controlValue, processValue; //variable for PID with default values


static inline float control(float setpoint,float feedback)
{
	processValue = feedback;
    lastError = Error;
    Error = setpoint - processValue;
    Integral = Integral + Error;
    Derivative = Error - lastError;
    controlValue = (Kp * Error) + (Ki * Integral) + (Kd * Derivative); //simple PID algorithm

	return controlValue;
}
