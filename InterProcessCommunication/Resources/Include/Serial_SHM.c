#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <fcntl.h>
#include <string.h>
#include <stdarg.h> //header for including unknown arguments
#include "SerialMI.h"

struct DataExchange {
    char sendVal[10][32];
    double getVal[10];
};

struct DataExchange *PID;
int fdshm;
void shmAccess()
{   
    if ((fdshm = shm_open("/MIGOD", O_CREAT | O_RDWR, 0660)) == -1)//, S_IRWXU | S_IRWXG);
        fprintf(stderr,"Failed to OPEN");

    if ((ftruncate(fdshm, sizeof(struct DataExchange))) == -1)
        fprintf(stderr,"Failed to TRUNC");

    if ((PID = mmap(NULL, sizeof(struct DataExchange), PROT_READ | PROT_WRITE, MAP_SHARED, fdshm, 0)) == MAP_FAILED)
        fprintf(stderr,"Failed to MMAP"); 
        close(fdshm);      
}

void shmWrite(int num1, double tagValue)
{
    PID-> getVal[num1] = tagValue; 
}

char *shmRead(int num2)
{
    char* returnVal;
    returnVal = PID->sendVal[num2];
    return returnVal;
}					

int main()
{
	char S_Port[32]="";
    int S_Baud;
    printf("Serial Port (e.g. /dev/ttyUSB0) : ");
    scanf("%s", S_Port);
    printf("Baud Rate (e.g. 115200) : ");
    scanf("%d", &S_Baud);
    serialBegin(S_Port, S_Baud);
    // serialBegin("/dev/ttyACM0", 115200);
    serialFlush();
    shmAccess();

    while(1)
    {
    	char* outData;
        char someData[32]="";
        const char* inData;
        char val[10]="";
        char addr[10]="";
        int i,j;
    
        for (i=0; i<10; i++)
        {    
            outData = shmRead(i);
            if(strcmp(outData, "") == 0);
            else{
            	printf("input:%s", outData);
            	serialWrite(outData);      
            	usleep(1000);
            	strcpy(PID->sendVal[i], "");
            }
        }

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
                shmWrite(atoi(addr), atof(val)); 
        }
    } 
printf("came out of loop..!");
serialEnd();
}

