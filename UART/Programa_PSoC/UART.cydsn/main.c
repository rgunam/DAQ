#include <project.h>
#include "stdio.h"

// Project Defines.
#define FALSE  0
#define TRUE   1
#define OFF    0
#define ON     1
#define TRANSMIT_BUFFER_SIZE  256


// Variables globales

uint8 ch; /* Variable para almacenar el caracter recibido.*/
char transmitBuffer[TRANSMIT_BUFFER_SIZE]; /*Buffer para almacenar la cadena a transmitir*/


int main(void)
{
    UART_1_Start(); /*Iniciamos comunicación UART*/
    
    CyGlobalIntEnable; /* Enable global interrupts. */

    
    for(;;)
    {
        ch = UART_1_GetChar();
        
            switch(ch){
                 case 0:
                // No hay dato recibido, no hace nada
                break;
                
                case 'E':
                Pin_2_LED_Write(ON);
                sprintf(transmitBuffer, "Hola PC soy PSoC: LED ENCENDIDO.\r\n");
                UART_1_PutString(transmitBuffer);
                break;
                
                case 'A':
                Pin_2_LED_Write(OFF);
                sprintf(transmitBuffer, "Hola PC soy PSoC: LED APAGADO\r\n");
                UART_1_PutString(transmitBuffer);
                break;
            }
    }
}

/* [] END OF FILE */
