%Script para comunicar PSoc con MATLAB
%MATLAB realiza la lectura del puerto serial COMX en donde
%el PSoC se encuentre conectado

% Desarroll�: RGRCH, II-UNAM 
% 2020

 
clear all
close all
clc
 
%Propiedades a definir y configuraci�n del puerto
serialPort = 'COM3';            % define # puerto COM 
baudRate = 115200;
s = serial(serialPort,'Baudrate',baudRate,'Terminator','CR/LF');

fopen(s); %abre el puerto

prompt = "Teclea la opci�n: \n A: apagar LED \n E: encender LED \n X: salir del programa \n";
str = input(prompt,'s'); %entrada de dato por Command Window de MATLAB

while 1  %ejecuci�n infinita del programa hasta presionar la tecla X
    
   switch str
       case 'A'
          fprintf(s,'A'); %env�a el comando (string) por puerto serie al PSoC
          dat = fscanf(s,'%s'); %recibe dato (string) por puerto del PSoC
          disp(dat) %despliega la cadena recibida en el Command Window de MATLAB para
                    %verificar que hay comunicaci�n bidireccional
          str = input(prompt,'s'); 
            if str == 'X'
                fclose(s);%Cierra el puerto
                delete(s);  
                break; %termina el programa
            end
          
       case 'E'
          fprintf(s,'E'); %env�a el comando (string) por puerto serie al PSoC
          dat = fscanf(s,'%s'); %recibe dato (string) por puerto del PSoC
          disp(dat) %despliega la cadena recibida en el Command Window de MATLAB para
                    %verificar que hay comunicaci�n bidireccional
          str = input(prompt,'s'); 
            if str == 'X'
                fclose(s);%Cierra el puerto
                delete(s);  
                break; %termina el programa
            end
            
       otherwise %en cualquier otro caso ejecuta el comando A para LED apgado
          fprintf(s,'A'); %env�a el comando (string) por puerto serie al PSoC
          dat = fscanf(s,'%s'); %recibe dato (string) por puerto del PSoC
          disp(dat) %despliega la cadena recibida en el Command Window de MATLAB para
                    %verificar que hay comunicaci�n bidireccional
          str = input(prompt,'s'); 
            if str == 'X'
                fclose(s);%Cierra el puerto
                delete(s);  
                break; %termina el programa
            end
        
            
   end
   
end
 


