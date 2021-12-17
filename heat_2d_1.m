
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

dx=1; % step size
dy=1;
dt = 0.1;
t_max = 300;

ts = 1:dt:t_max;

lambda=0.1; % arbitrary thermal diffusivity 

r = lambda*(dt/dx^2); %it has to be less than 0.5 to have stability

%--initial condition------------------------------------------------------

U0 = zeros(size(im));
%U0 = im;

%--boundary conditions----------------------------------------------------

inds = find(mask == 0);
[rows, cols] = ind2sub(size(mask),inds);

% pd_im = fitdist(reshape(im,[(imX*imY),1]),'Normal');
% 
% im_n = im;
% 
% for i = 1:size(inds)
%     im_n(inds(i,1)) = random(pd_im);
% end
% 
% imshow(im_n);
% figure

%---finite difference scheme----------------------------------------------

L_X=(1/(dx^2))*(diag(-2*ones(imX,1)) + diag(ones(imX-1,1),1) + diag(ones(imX-1,1),-1));
%condizioni di Neumann con differenze finite in avanti
L_X(1,1)=-1/dx^2;
L_X(imX,imX)=-1/dx^2;
L_Y=(1/(dy^2))*(diag(-2*ones(imY,1)) + diag(ones(imY-1,1),1) + diag(ones(imY-1,1),-1));
L_Y(1,1)=-1/dy^2;
L_Y(imY,imY)=-1/dy^2;

U = U0;

chi = zeros(size(mask));
chi_ind = find(mask == 1);
chi(chi_ind) = 1;

for k = 1:size(ts,2)
    
    
    U = U+dt*(L_X*U+U*L_Y+10*mask.*(im-U));

end

%--display image inpainted----------------------------------------------

subplot(1,2,1);
imshow(im2uint8(im));
title('Image to be inpainted')
subplot(1,2,2);
imshow(im2uint8(U));
title('Inpainted Image');

%------------------------------------------------------------------------





