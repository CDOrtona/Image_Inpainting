
%------------------------------------------------------------------------
%--- Heat Equation in two dimensions-------------------------------------
%--- Solves Ut=alpha*(Uxx+Uyy)-------------------------------------------
%------------------------------------------------------------------------

clc;
close all;
clear;

%% Inizializzazione imaggini
%

mask = im2double(imread(uigetfile('*.jpg; *.png; *.bmp', "Select the mask")));
I = im2double(imread(uigetfile('*.jpg; *.png; *.bmp', "Select the image")));

[imX, imY] = size(I);

%--dimensions...........................................................
%%%se riduco dt ho più iterazioni e quindi più tempo ma meno diffusione, 
%%%se riduco le iterazioni quindi aumento dt ho meno tempo ma anche più diffusione
%%%se riduco le iterazioni quindi diminuisco t_max ho meno tempo e minore
%%%diffusione, quindi potrei aumentare delta
dx=1; %passi discretizzazione spaziale
dy=1;
dt = 0.4; %passo discretizzazione temporale
t_max = 500; 

ts = 1:dt:t_max;
ts_n = size(ts,2);

%lambda=0.1; % arbitrary thermal diffusivity 
lambda = 0.5;

%CFL condition deve essere inferiore a 0.5 per avere stabilità
r = lambda*(dt/dx^2); 

%Condizione iniziale
U0 = zeros(size(I));

L_X=(diag(-2*r*ones(imX,1)) + diag(r*ones(imX-1,1),1) + diag(r*ones(imX-1,1),-1));
L_Y=(diag(-2*r*ones(imY,1)) + diag(r*ones(imY-1,1),1) + diag(r*ones(imY-1,1),-1));

%Condizioni di Neumann
L_X(1,2)=2*r;
L_X(imX,imX-1)=2*r;
L_Y(1,2)=2*r;
L_Y(imY,imY-1)=2*r;

chi = zeros(size(mask));
chi_ind = find(mask == 1);
chi(chi_ind) = 1;

U_old = U0;
U_new = size(U_old);

tic;
for k = 1:ts_n
    
    U_new = U_old+L_X*U_old+U_old*L_Y+dt*(chi.*(I-U_old));
    U_old = U_new;
    
    figure(1);
    imagesc(U_new,[0 1]), axis equal; axis off; colormap(gray)
    title([num2str(k) 'timesteps'])

end
t=toc

Irestored = U_new;

%--display image inpainted----------------------------------------------

subplot(1,2,1);
imshow(im2uint8(I));
title('Image to be inpainted')
subplot(1,2,2);
imshow(im2uint8(Irestored));
title('Inpainted Image');

%PSNR
Irestored = im2uint8(Irestored);
mask = im2uint8(mask);
peaksnr = psnr(U_new,I);



