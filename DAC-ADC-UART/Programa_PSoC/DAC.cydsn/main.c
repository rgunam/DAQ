#include <project.h>
#include "stdio.h"

// Project Defines.
#define FALSE  0
#define TRUE   1
#define OFF    0
#define ON     1
#define TRANSMIT_BUFFER_SIZE 256

char transmitBuffer[TRANSMIT_BUFFER_SIZE]; /*Buffer para almacenar la cadena a transmitir*/

int main(void)
{
    CyGlobalIntEnable; /* Enable global interrupts. */
    WaveDAC8_1_Start(); //Start the WaveDAC. 
    UART_1_Start(); /*Iniciamos comunicación UART*/
    ADC_Start();
    int16 Pot_val; //variable en donde almacenamos el
                   // dato del ADC

    /* Place your initialization/startup code here (e.g. MyInst_Start()) */

    for(;;)
    {
       
       ADC_StartConvert(); // Inicia la conversión A/D
       ADC_IsEndConversion(ADC_WAIT_FOR_RESULT); // Espera a que la conversión haya finalizado
       Pot_val = ADC_GetResult16(); //Guarda el resultado de la conversión
       sprintf(transmitBuffer,"%d\r\n",Pot_val);  // Convierte de entero a cadena para poder enviar por UART
       UART_1_PutString(transmitBuffer);
       //CyDelay(200u);
    }
}

/* [] END OF FILE */
