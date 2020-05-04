%Script para comunicar ARDUINO con MATLAB
%MATLAB realiza la lectura del puerto serial COMX en donde
%Arduino se encuentre conectado

%Arduino lee UN SOLO CANAL ANALÓGICO y envía el dato por UART

 
clear all
close all
clc
 
%Propiedades a definir
serialPort = 'COM3';            % define # puerto COM 
baudRate = 115200;
plotTitle = '';                 % título de la gráfica
xLabel = 'Tiempo(s)';           % x-axis label
yLabel = 'Dato';                % y-axis label
plotGrid = 'on';                % 'off' si deseamos quitar cuadrícula en la gráfica
min = -1;                       % establece escala eje y-min
max = 1;                        % establece escala eje y-max
scrollWidth = 10;               % ventana de tiempo (eje x)
delay = 0.5;                     % tiempo entre muestras (debe coincidiar aprox.
                                % con el CyDelay del main.c en el PSoC
 
%Define variables de funcionamiento
time = 0;               %tiempo
data = 0;               %datos adquiridos
count = 0;              %contador de control
 
%Prepara la gráfica
plotGraph = plot(time,data,'-b','LineWidth',1);
xlabel(xLabel,'FontSize',12);  %Etiqueta eje x
ylabel(yLabel,'FontSize',12);   %Etiqueta eje y
axis 'auto y';          %autoescala en eje y
grid(plotGrid);         %pone cuadrícula
 
%Abre el puerto serial COM
s = serial(serialPort,'Baudrate',baudRate,'Terminator','CR/LF');
disp('Si desea terminar la ejecución cierre la grafica');      %Leyenda al finalizar la ejecución
fopen(s);
dat = fscanf(s,'%d'); %Lee el dato del puerto serial en formato entero
tic %tiempo inicial
i=0; 
while ishandle(plotGraph) %Ciclo permanente mientras la ventana esté abierta
    dat = fscanf(s,'%d'); %Lee el dato del puerto serial en formato entero
    i=i+1;
    if(~isempty(dat) && isfloat(dat)) %Verifica el tipo de dato     
        count = count + 1;    
        time(count) = toc;    %Extrae el tiempo acumulado
        data(count) = dat(1); %Extrae únicamente el dato del ADC
         
        %Esta función es para dar efecto de un Osciloscopio (NO MODIFICIAR)
        if(scrollWidth > 0)
        set(plotGraph,'XData',time(time > time(count)-scrollWidth),'YData',data(time > time(count)-scrollWidth));
        axis([time(count)-scrollWidth time(count) min max]);
        axis 'auto y'
        else
        set(plotGraph,'XData',time,'YData',data);
        axis([0 time(count) min max]);
        axis 'auto y'
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
         
        %Actualiza gráfica
        %pause(delay);
        drawnow
    end
end
 
%Cierra el puerto y elimina variables que ya no se utilizarán
fclose(s);
delete(s);
clear count dat delay max min plotGraph plotGrid plotTitle s ...
        scrollWidth serialPort xLabel yLabel;
 
 
disp('Termino ejecución...');