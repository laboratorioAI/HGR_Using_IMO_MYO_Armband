%%-------------------------------------------------------------
clc
close all
%%---------------------------------------------------------------
% IMAGENES DE LOS GESTOS

im1=imread('NODISPONIBLE.jpg');
im2=imread('UP.jpg');
im3=imread('DOWN.jpg');
im4=imread('LEFT.jpg');
im5=imread('RIGHT.jpg');
im6=imread('FORDWARD.jpg');
im7=imread('BACKWARD.jpg');
im8=imread('GIRO_DERECHA.jpg');
im9=imread('GIRO_IZQUIERDA.jpg');
%%---------------------------------------------------------------
% PRESENTACIÓN
while (true)
    
disp('RECONOCIMIENTO DE MOVIMIENTOS DEL BRAZO UTILIZANDO LA IMU')
disp('Bienvenido al sistema de reconocimiento de los movimientos del brazo con  Myo Armband.')
disp('El   sistema   permite   el   reconocimiento  de  ocho  movimientos del brazo.')
disp('- UP (Arriba)')
disp('- DOWN (Abajo)')
disp('- RIGHT (Derecha)')
disp('- LEFT (Izquierda)')
disp('- FORDWARD (Adelante)')
disp('- BACKWARD (Atras)')
disp('- GIRO HORARIO-HORIZONTAL')
disp('- GIRO ANTIHORARIO-HORIZONTAL')
disp('')
disp('RECOMENDACIONES')
disp('* Colocarse el brazalete a 6 [cm] aproximadamente desde CODO al MYO ARMBAND.')
disp('* Si es necesario, se debe realizar un ajuste del brazalete')
disp('* Verificar que el logo de THALMIC  este estático (NO PARPADEANDO).')
opc = input(' [1] INICIO  \n [2] SALIR \n:');

%%-------------------------------------------------------------------------
%INICIALIZACION DE VARIABLES

Tiempo=0.12;
cont=1;
i=1;
pitch=zeros(1,1);
yaw=zeros(1,1);
roll=zeros(1,1);

%-------------------------------------------------------------------


switch opc
    
    case 1 
disp('TOMA DE MUESTRA INICIAL - PUNTO DE REFERENCIA INICIAL')
disp('INDICACIONES:')
disp('- Coloque el brazo en la posición incial en la cual va realizar los movimientos')
disp('- Después de la realizción de cada movimiento procure regresar a la posición incial.')
      pause(6)

disp('La muestra inicial se tomara a la cuenta de 3:')
    while (cont<=3)
     fprintf("La cuenta esta en : %d\n",cont)
     cont=cont+1;
     pause(2)
    end
    
pitch0=(180/pi)*(asin(2*(d.quat(1)*d.quat(3)-d.quat(4)*d.quat(2))));
yaw0=(180/pi)*atan2((2*(d.quat(1)*d.quat(4)+d.quat(2)*d.quat(3))),1-2*(d.quat(3)^2+d.quat(4)^2));
yaw01=((180/pi)*atan2(2*(d.quat(1)*d.quat(4)+d.quat(2)*d.quat(3)),((d.quat(3)^2+d.quat(4)^2))^2));
roll0=(180/pi)*atan2(2*(d.quat(1)*d.quat(2)+d.quat(3)*d.quat(4)),1-2*(d.quat(2)^2+d.quat(3)^2));

disp(yaw0);
disp(yaw01);
%%---------------------------
%Condición del desbordamiento

if (yaw0 >= -180 && yaw0 <= -90) 
    fprintf("DESBORDAMIENTO NEGATIVO");
   while(i<=250)
    
pause(Tiempo)

pitch(i,1)=((180/pi)*(asin(2*(d.quat(1)*d.quat(3)-d.quat(4)*d.quat(2)))))-pitch0;
yaw(i,1)=1.25*((((180/pi)*atan2(2*(d.quat(1)*d.quat(4)+d.quat(2)*d.quat(3)),((d.quat(3)^2+d.quat(4)^2))^2)))-(yaw01));
roll(i,1)=(180/pi)*atan2(2*(d.quat(1)*d.quat(2)+d.quat(3)*d.quat(4)),1-2*(d.quat(2)^2+d.quat(3)^2))-roll0;

        if (yaw(i,1)<=40 && roll(i,1)>=50)
                
                 fprintf(1,'\n %s \n','FORDWARD');
                 subplot(1,4,4)
                 imshow(im6);
                 title('FORDWARD')
                 
        else
            if(pitch(i,1)>=50 && roll(i,1)<=-25 && yaw(i,1)>=40)
                 
                 fprintf(1,'\n %s \n','BACKWARD');
                 subplot(1,4,4)
                 imshow(im7);
                 title('BACKWARD')
            else
          
                if ( yaw(i,1)>=35)
                    
                    fprintf(1,'\n %s \n','RIGHT');
                    subplot(1,4,4)
                    imshow(im5);
                    title('RIGHT')
                    
                else
                     if ( yaw(i,1)<=-25)
                         
                         fprintf(1,'\n %s \n','LEFT');
                         subplot(1,4,4)
                         imshow(im4);
                         title('LEFT')
                     else
                          if ( pitch(i,1)>=50)
                              fprintf(1,'\n %s \n','UP');
                              subplot(1,4,4)
                              imshow(im2);
                              title('UP')
                          else
                               if ( pitch(i,1)<=-40)
                                   fprintf(1,'\n %s \n','DOWN');
                                   subplot(1,4,4)
                                   imshow(im3);
                                   title('DOWN')
                               else
                                    if ( roll(i,1)>=30)
                                        fprintf(1,'\n %s \n','GIRO IZQUIERDA');
                                        subplot(1,4,4)
                                        imshow(im9);
                                        title('GIRO IZQUIERDA')
                                    else
                                         if ( roll(i,1)<=-30)
                                             fprintf(1,'\n %s \n','GIRO DERECHA');
                                             subplot(1,4,4)
                                             imshow(im8);
                                             title('GIRO DERECHA')
                                         else
                                             if(roll(i,1) && pitch(i,1) && yaw(i,1)<= 5)
                                                 fprintf(1,'\n %s \n','NINGUN GESTO');
                                                 subplot(1,4,4)
                                                 imshow(im1);
                                                 title('NINGUN GESTO')
                                             else
                                                 if(roll(i,1) && pitch(i,1) && yaw(i,1)>= -5)
                                                 fprintf(1,'\n %s \n','NINGUN GESTO');
                                                 subplot(1,4,4)
                                                 imshow(im1);
                                                 title('NINGUN GESTO')
                                                 end 
                                             end
                                         end
                                    end
                               end
                          end
                     end
                end
            end
        end



subplot (1,4,1)
plot(pitch)
ylim([-100 100])
title('PITCH')
subplot (1,4,2)
plot(yaw)
ylim([-100 100])
title('YAW')
subplot (1,4,3)
plot(roll)
ylim([-100 100])
title('ROLL')

i=i+1;
   end
   
else
    if(yaw0 <= 180 && yaw0 >= 90)
        fprintf("DESBORDAMIENTO POSITIVO");
 while(i<=250)
    
pause(Tiempo)

pitch(i,1)=((180/pi)*(asin(2*(d.quat(1)*d.quat(3)-d.quat(4)*d.quat(2)))))-pitch0;
yaw(i,1)=1.15*((((180/pi)*atan2(2*(d.quat(1)*d.quat(4)+d.quat(2)*d.quat(3)),((d.quat(3)^2+d.quat(4)^2))^2)))-(yaw01));
roll(i,1)=(180/pi)*atan2(2*(d.quat(1)*d.quat(2)+d.quat(3)*d.quat(4)),1-2*(d.quat(2)^2+d.quat(3)^2))-roll0;

        if (yaw(i,1)<=-20 && roll(i,1)>=20)
                
                 fprintf(1,'\n %s \n','FORDWARD');
                 subplot(1,4,4)
                 imshow(im6);
                 title('FORDWARD')
                 
        else
            if(pitch(i,1)>=50 && roll(i,1)<=-30 && yaw(i,1)>=30)
                 
                 fprintf(1,'\n %s \n','BACKWARD');
                 subplot(1,4,4)
                 imshow(im7);
                 title('BACKWARD')
            else
          
                if ( yaw(i,1)>=35)
                    
                    fprintf(1,'\n %s \n','RIGHT');
                    subplot(1,4,4)
                    imshow(im5);
                    title('RIGHT')
                    
                else
                     if ( yaw(i,1)<=-40)
                         
                         fprintf(1,'\n %s \n','LEFT');
                         subplot(1,4,4)
                         imshow(im4);
                         title('LEFT')
                     else
                          if ( pitch(i,1)>=50)
                              fprintf(1,'\n %s \n','UP');
                              subplot(1,4,4)
                              imshow(im2);
                              title('UP')
                          else
                               if ( pitch(i,1)<=-50)
                                   fprintf(1,'\n %s \n','DOWN');
                                   subplot(1,4,4)
                                   imshow(im3);
                                   title('DOWN')
                               else
                                    if ( roll(i,1)>=30)
                                        fprintf(1,'\n %s \n','GIRO IZQUIERDA');
                                        subplot(1,4,4)
                                        imshow(im9);
                                        title('GIRO IZQUIERDA')
                                    else
                                         if ( roll(i,1)<=-30)
                                             fprintf(1,'\n %s \n','GIRO DERECHA');
                                             subplot(1,4,4)
                                             imshow(im8);
                                             title('GIRO DERECHA')
                                         else
                                             if(roll(i,1) && pitch(i,1) && yaw(i,1)<= 5)
                                                 fprintf(1,'\n %s \n','NINGUN GESTO');
                                                 subplot(1,4,4)
                                                 imshow(im1);
                                                 title('NINGUN GESTO')
                                             else
                                                 if(roll(i,1) && pitch(i,1) && yaw(i,1)>= -5)
                                                 fprintf(1,'\n %s \n','NINGUN GESTO');
                                                 subplot(1,4,4)
                                                 imshow(im1);
                                                 title('NINGUN GESTO')
                                                 end 
                                             end
                                         end
                                    end
                               end
                          end
                     end
                end
            end
        end



subplot (1,4,1)
plot(pitch)
ylim([-100 100])
title('PITCH')
subplot (1,4,2)
plot(yaw)
ylim([-100 100])
title('YAW')
subplot (1,4,3)
plot(roll)
ylim([-100 100])
title('ROLL')

i=i+1;  
end 
        
    else 
        fprintf("NO HAY DESBORDAMIENTO");
%Programa de clasificacion de gestos principal
    while(i<=250)
    
pause(Tiempo)

pitch(i,1)=((180/pi)*(asin(2*(d.quat(1)*d.quat(3)-d.quat(4)*d.quat(2)))))-pitch0;
yaw(i,1)=(180/pi)*atan2((2*(d.quat(1)*d.quat(4)+d.quat(2)*d.quat(3))),1-2*(d.quat(3)^2+d.quat(4)^2))-yaw0;
roll(i,1)=(180/pi)*atan2(2*(d.quat(1)*d.quat(2)+d.quat(3)*d.quat(4)),1-2*(d.quat(2)^2+d.quat(3)^2))-roll0;

        if (yaw(i,1)>=55 && roll(i,1)>=30)
                
                 fprintf(1,'\n %s \n','FORDWARD');
                 subplot(1,4,4)
                 imshow(im6);
                 title('FORDWARD')
                 
        else
            if(pitch(i,1)>=45 && roll(i,1)<=-25 && yaw(i,1)<=-45)
                 
                 fprintf(1,'\n %s \n','BACKWARD');
                 subplot(1,4,4)
                 imshow(im7);
                 title('BACKWARD')
            else
          
                if ( yaw(i,1)>=55)
                    
                    fprintf(1,'\n %s \n','LEFT');
                    subplot(1,4,4)
                    imshow(im4);
                    title('LEFT')
                    
                else
                     if ( yaw(i,1)<=-50)
                         
                         fprintf(1,'\n %s \n','RIGHT');
                         subplot(1,4,4)
                         imshow(im5);
                         title('RIGHT')
                     else
                          if ( pitch(i,1)>=50)
                              fprintf(1,'\n %s \n','UP');
                              subplot(1,4,4)
                              imshow(im2);
                              title('UP')
                          else
                               if ( pitch(i,1)<=-50)
                                   fprintf(1,'\n %s \n','DOWN');
                                   subplot(1,4,4)
                                   imshow(im3);
                                   title('DOWN')
                               else
                                    if ( roll(i,1)>=30)
                                        fprintf(1,'\n %s \n','GIRO IZQUIERDA');
                                        subplot(1,4,4)
                                        imshow(im9);
                                        title('GIRO IZQUIERDA')
                                    else
                                         if ( roll(i,1)<=-30)
                                             fprintf(1,'\n %s \n','GIRO DERECHA');
                                             subplot(1,4,4)
                                             imshow(im8);
                                             title('GIRO DERECHA')
                                         else
                                             if(roll(i,1) && pitch(i,1) && yaw(i,1)<= 5)
                                                 fprintf(1,'\n %s \n','NINGUN GESTO');
                                                 subplot(1,4,4)
                                                 imshow(im1);
                                                 title('NINGUN GESTO')
                                             else
                                                 if(roll(i,1) && pitch(i,1) && yaw(i,1)>= -5)
                                                 fprintf(1,'\n %s \n','NINGUN GESTO');
                                                 subplot(1,4,4)
                                                 imshow(im1);
                                                 title('NINGUN GESTO')
                                                 end 
                                             end
                                         end
                                    end
                               end
                          end
                     end
                end
            end
        end



subplot (1,4,1)
plot(pitch)
ylim([-100 100])
title('PITCH')
subplot (1,4,2)
plot(yaw)
ylim([-100 100])
title('YAW')
subplot (1,4,3)
plot(roll)
ylim([-100 100])
title('ROLL')

i=i+1;
    end
   end
end
    case 2
        break;
end
end
