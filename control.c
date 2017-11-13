#include <fcntl.h>
#include <string.h>
#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include <stdint.h>


#ifndef PID_H_
#define PID_H_


//Defineparameter
#define MAX 5 //Saturation
#define MIN 0

#define Kp 0.1

float control(float setpoint,float feedback)
{
	staticfloat pre_error= 0;
	float error;
	float output;
	//CaculateP,I,D
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