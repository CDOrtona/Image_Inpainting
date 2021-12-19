
%------------------------------------------------------------------------
%--- Heat Equation in two dimensions-------------------------------------
%--- Solves Ut=alpha*(Uxx+Uyy)-------------------------------------------
%------------------------------------------------------------------------

clc;
close all;
clear;

%--image initialization------------------------------------------------------------------

mask = im2double(imread(uigetfile('*.jpg; *.png; *.bmp', "Select the mask")));
im = im2double(imread(uigetfile('*.jpg; *.png; *.bmp', "Select the image")));

[imX, imY] = size(im);

%--dimensions...........................................................
%%%se riduco dt ho più iterazioni e quindi più tempo ma meno diffusione, 
%%%se riduco le iterazioni quindi aumento dt ho meno tempo ma anche più diffusione
%%%se riduco le iterazioni quindi diminuisco t_max ho meno tempo e minore
%%%diffusione, quindi potrei aumentare delta
dx=1; % step size
dy=1;
dt = 0.4;
t_max = 500;

ts = 1:dt:t_max;

%lambda=0.1; % arbitrary thermal diffusivity 
lambda = 0.5;

r = lambda*(dt/dx^2); %it has to be less than 0.5 to have stability

%--initial condition------------------------------------------------------

U = zeros(size(im));

%---finite difference scheme----------------------------------------------

L_X=(diag(-2*r*ones(imX,1)) + diag(r*ones(imX-1,1),1) + diag(r*ones(imX-1,1),-1));
L_Y=(diag(-2*r*ones(imY,1)) + diag(r*ones(imY-1,1),1) + diag(r*ones(imY-1,1),-1));
%condizioni di Neumann con differenze finite in avanti
L_X(1,1)=-r;
L_X(imX,imX)=-r;
L_Y(1,1)=-r;
L_Y(imY,imY)=-r;

chi = zeros(size(mask));
chi_ind = find(mask == 1);
chi(chi_ind) = 1;
tic;
for k = 1:size(ts,2)
    
    U = U+L_X*U+U*L_Y+dt*(mask.*(im-U));
    figure(1);
    imagesc(U,[0 1]), axis equal; axis off; colormap(gray)
    title(['Inpainted image as solution to heat equation after '...
        num2str(k) ' timesteps'])

end
t=toc
%--display image inpainted----------------------------------------------

subplot(1,2,1);
imshow(im2uint8(im));
title('Image to be inpainted')
subplot(1,2,2);
imshow(im2uint8(U));
title('Inpainted Image');

%------------------------------------------------------------------------

peaksnr = psnr(U,im);



