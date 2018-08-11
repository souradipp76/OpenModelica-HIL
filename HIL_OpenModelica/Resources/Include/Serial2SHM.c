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
void ShmAccess()
{   
    if ((fdshm = shm_open("/MIGOD", O_CREAT | O_RDWR, 0660)) == -1)
        fprintf(stderr,"Failed to OPEN");

    if ((ftruncate(fdshm, sizeof(struct DataExchange))) == -1)
        fprintf(stderr,"Failed to TRUNC");
    if ((PID = mmap(NULL, sizeof(struct DataExchange), PROT_READ | PROT_WRITE, MAP_SHARED, fdshm, 0)) == MAP_FAILED)
        fprintf(stderr,"Failed to MMAP"); 
        close(fdshm);   
}

void ShmWrite(int num1, double tagValue)
{
    char outData[]="";
    ShmAccess();
    sprintf(outData,"%d,%g\n", num1,tagValue);
    strcpy(PID-> sendVal[num1], outData);
    PID-> getVal[num1] = tagValue;
    //return 0;
}

char *ShmRead(int num2)
{
    char* retrunVal;
    retrunVal = PID->sendVal[num2];
    return retrunVal;
}		

double SerialToShm(int Port,int S_Baud)
{
	char S_Port[32]="";
	sprintf(S_Port,"/dev/ttyACM%d",Port);
	serialBegin(S_Port, S_Baud);

    ShmAccess();
	
	int i,j;
	char val[20]="";
	char someData[32]="";
	const char* inData;
    char addr[20]="";
	if(serialAvailable()>0)
    {
        inData = serialRead();
        strcpy(someData, inData);
        printf("ardOutput:%s\n", someData);
        for(i=0; i<strlen(someData); i++)
        {
            if(someData[i]==',') 
            {
                addr[i]='\0';
                i++;
                break;
            }
            addr[i] = someData[i];
        }
        
        for(j=i; j<strlen(someData); j++)
        {
            val[j-i] = someData[j];
        }
        ShmWrite(atoi(addr), atof(val)); 
    }
    //serialEnd();
    return 0;
}

double ShmToSerial(int Port,int S_Baud)
{
	char S_Port[32]="";
	sprintf(S_Port,"/dev/ttyACM%d",Port);
	serialBegin(S_Port, S_Baud);
    serialFlush();

    printf("%s\n",S_Port);
    ShmAccess();
    int i,j;
	char* outData;
    for (i=0; i<10; i++)
    {    
        outData = ShmRead(i);
        if(strcmp(outData,"") != 0)
        {
            printf("input:%s\n", outData);
            serialWrite(outData);     
            usleep(1000); 
            strcpy(PID->sendVal[i], "");
            break;
        }
    }
    serialEnd();
    return 0;
}
