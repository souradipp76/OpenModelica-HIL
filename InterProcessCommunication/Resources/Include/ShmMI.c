#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <fcntl.h>
#include <string.h>

struct DataExchange {
    char sendVal[10][32];
    double getVal[10];
};

struct DataExchange *PID;
int fdshm;
void shmAccess()
{   
    if ((fdshm = shm_open("/MIGOD", O_CREAT | O_RDWR, 0660)) == -1)
    	fprintf(stderr,"Failed to OPEN");

    if ((ftruncate(fdshm, sizeof(struct DataExchange))) == -1)
    	fprintf(stderr,"Failed to TRUNC");
    if ((PID = mmap(NULL, sizeof(struct DataExchange), PROT_READ | PROT_WRITE, MAP_SHARED, fdshm, 0)) == MAP_FAILED)
 		fprintf(stderr,"Failed to MMAP"); 
 		close(fdshm);  	
}

double shmWrite(int num1, double tagValue)
{
	char outData[]="";
	shmAccess();
	
	sprintf(outData,"%d,%g\n", num1, tagValue);
	strcpy(PID-> sendVal[num1], outData);
	return 0;
}

double shmRead(int num2)
{
	shmAccess();

	double retrunVal=0;
	retrunVal = PID->getVal[num2];
	return retrunVal;
}
	
/*void main()
{
	_tMemoryAccess();
	double readVal[5];
	_tMemoryWrite(3, 3.366, 4.422, 5.5666);
	int i;
	readVal[0] = _tMemoryRead(0);
	readVal[1] = _tMemoryRead(1);
	readVal[2] = _tMemoryRead(2);
	for(i=0; i<3; i++)
		printf("%g\t", readVal[i]);
	printf("\n");
}*/