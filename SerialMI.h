#ifndef SerialMI_H_
#define SerialMI_H_

//#include <stdio.h>
#include <fcntl.h> //file control definitions
#include <termios.h> //POSIX terminal control definitions
#include <unistd.h> //UNIX standard definitions
#include <errno.h> //error number definitions
#include <stdlib.h>
#include <string.h>
#include <sys/ioctl.h>

int fd=0;
int serialBegin(char *portname, int baudrate)
{
	fd = open(portname, O_RDWR | O_NOCTTY| O_NDELAY);

	if(fd<0)
	{
		printf("\n Device not found! \n");
		return -1;
	}
	
	//printf("* * * * * * * * * * * * * * * *\nconnected %s at %d     \n* * * * * * * * * * * * * * * *\n", portname, baudrate);
	fcntl(fd, F_SETFL, 0);

	struct termios serialSetup; //declare a termios structure
	memset(&serialSetup, 0, sizeof serialSetup);
	if(tcgetattr (fd, &serialSetup) != 0) //to get current settings of serial port args: file descriptor fd and address of structure
	{
		printf("error %d while getting attrs", errno);
		return -1;
	}
	speed_t speed = 0;
	switch(baudrate)
	{
		case 4800:
			speed = B4800;
			break;

		case 9600:
			speed = B9600;
			break;

		case 19200:
			speed = B19200;
			break;

		case 38400:
			speed = B38400;
			break;

		case 115200:
			speed = B115200;
			break;

		default:
			printf("\nInvalid Baudrate\n");
			return 1;
			break;
	}
	cfsetospeed(&serialSetup, speed); //write speed, linux allows two speeds for read and write
	cfsetispeed(&serialSetup, speed); //read speed, keep both same

	serialSetup.c_cflag |= (CREAD | CLOCAL); //turn on the receiver
	serialSetup.c_cflag &= ~(CSIZE | PARENB | CSTOPB | CRTSCTS); //clear parity bit, 1 stop bit, h/w based flow control
	serialSetup.c_cflag |= CS8; //character size 8 bit


	//setup for non canonical mode
	serialSetup.c_iflag &= ~(IXON | IXOFF | IXANY );//| IGNBRK | INLCR | ICRNL | IGNCR); //turn off software based flow control (BRKINT 
	serialSetup.c_lflag &= ~(ECHO | ECHOE | ICANON | ISIG);// | IEXTEN); //start non canonical mode of operation
	serialSetup.c_oflag &= ~OPOST;

	//Serial read time outs
	serialSetup.c_cc[VMIN] = 1; //minimum number of characters to be read before read call
	serialSetup.c_cc[VTIME] = 10; //wait indefinitely

	//tcsetattr(fd, TCSANOW, &serialSetup);
	//tcsetattr(fd, TCSAFLUSH, &serialSetup);
	
	if (tcsetattr(fd, TCSANOW, &serialSetup) != 0)
	{
		printf("Error while setting attrs: %s\n", strerror(errno));
		return -1;
	}
	printf("Serial connection established.\n");
	return fd;
}

const char* serialRead()
{
	static char read_buff[32]="";
	char temp_char='\0';
	int i=0;
	//int byte_r = read(fd, &temp_buff, sizeof(read_buff));
	for(i=0; i<32; i++)
	{
		int byte_r = read(fd, &temp_char, 1);
		if(temp_char == '\n') break; 
		
		read_buff[i] = temp_char;
	}
	read_buff[i] = '\0';
	return read_buff;
}

void serialWrite(char *write_buff)
{
	int bytes_w =0;
	bytes_w = write(fd, write_buff, strlen(write_buff)); //write system call( file descriptor, pointer to data, number of bytes)
	if(bytes_w<0) fprintf(stderr, "Error in writing data");
}

int serialAvailable()
{
	int find;
	ioctl(fd, FIONREAD, &find);
	usleep(100);
	return find;
}

void serialFlush()
{
	tcflush(fd, TCIOFLUSH);
}

void serialWait()
{
	tcdrain(fd);
}

void serialEnd()
{
	close(fd);
}
#endif //SerialMI.h

