//#include TM4C123GH6PM.h'
#include "stdio.h"
#include "string.h"
#include "stm32f4xx.h"
void printMsg1(const int a)
{
	 char Msg[100];
	 char *ptr;
	 sprintf(Msg, "\n%f", *((float*)&a));
	 ptr = Msg ;
   while(*ptr != '\0'){
      ITM_SendChar(*ptr);
     //printf("shubham"); 
		 ++ptr;
   }
}


void printMsg2(const int a)
{
	 char Msg[100];
	 char *ptr;
	 sprintf(Msg, "\t%f", *((float*)&a));
	 ptr = Msg ;
   while(*ptr != '\0'){
      ITM_SendChar(*ptr);
     //printf("shubham"); 
		 ++ptr;
   }
}
