#include <project.h>
#include "stdio.h"

#define TRANSMIT_BUFFER_SIZE 256

char transmitBuffer[TRANSMIT_BUFFER_SIZE]; 

int main(void)
{
    CyGlobalIntEnable; /* Enable global interrupts. */
    VDAC8_1_Start();
    UART_1_Start(); /*Iniciamos comunicación UART*/
    ADC_Start();
    uint8 i=0;
    int16 Pot_val; //variable en donde almacenamos el
                   // dato del ADC

    for(;;)
    {
       CyDelay(10);
       VDAC8_1_SetValue(i);
       ADC_StartConvert(); // Inicia la conversión A/D
       ADC_IsEndConversion(ADC_WAIT_FOR_RESULT); // Espera a que la conversión haya finalizado
       Pot_val = ADC_GetResult16(); //Guarda el resultado de la conversión
       sprintf(transmitBuffer,"%d\r\n",Pot_val);  // Convierte de entero a cadena para poder enviar por UART
       UART_1_PutString(transmitBuffer); 
       i++;
    }
}

/* [] END OF FILE */
