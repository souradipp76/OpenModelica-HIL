#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <fcntl.h>
#include <string.h>
#include <stdarg.h>
#include "SerialMI.h"

struct DataExchange {
    char sendVal[10][32];
    double getVal[10];
};

struct DataExchange *PID;
int fdshm;
void shmAccess()
{   
    if ((fdshm = shm_open("/MIGOD", O_CREAT | O_RDWR, 0660)) == -1)
        fprintf(stderr,"Failed to OPEN\n");
    else if ((ftruncate(fdshm, sizeof(struct DataExchange))) == -1)
        fprintf(stderr,"Failed to TRUNC\n");
    else if ((PID = mmap(NULL, sizeof(struct DataExchange), PROT_READ | PROT_WRITE, MAP_SHARED, fdshm, 0)) == MAP_FAILED)
        fprintf(stderr,"Failed to MMAP\n"); 
        close(fdshm);   
}


void shmWrite(int num1, double tagValue)
{
    char outData[]="";
    shmAccess();
    sprintf(outData,"%g\n", tagValue);
    strcpy(PID-> sendVal[num1], outData);
    PID-> getVal[num1] = tagValue;
    //return 0;
}

double shmRead(int num2)
{
    shmAccess();

    double retrunVal=0;
    retrunVal = PID->getVal[num2];
    return retrunVal;
}				

double SerialToShm(int addr,int Port,int S_Baud)
{
	char S_Port[32]="";
	sprintf(S_Port,"/dev/ttyACM%d",Port);
	serialBegin(S_Port, S_Baud);
    shmAccess();


	int i,j;
	char val[20]="";
	char someData[32]="";
	const char* inData;
	if(serialAvailable()>0)
    {
            inData = serialRead();
            strcpy(someData, inData);
            
            for(j=0; j<strlen(someData); j++)
            {
                val[j] = someData[j];
            }
            shmWrite(addr, atof(val)); 
    }
    return 0;
}

double ShmToSerial(int addr,int Port,int S_Baud)
{
	char S_Port[32]="";
	sprintf(S_Port,"/dev/ttyACM%d",Port);
	serialBegin(S_Port, S_Baud);
    serialFlush();
    shmAccess();


	double outData;

    outData = shmRead(addr);
    if(outData != 0){
    printf("%g", outData);
    char outstr[32];
    sprintf(outstr,"%g",outData);
    serialWrite(outstr);      
    serialWait();
    strcpy(PID->sendVal[addr], "");
    }

    return 0;
}
