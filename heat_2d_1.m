
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
dt = 0.5;
t_max = 2000;

ts = 1:dt:t_max;

lambda=0.1; % arbitrary thermal diffusivity 

r = lambda*(dt/dx^2); %it has to be less than 0.5 to have stability

%--initial condition------------------------------------------------------

%inds = find(mask == 0);
%[rows, cols] = ind2sub(size(mask),inds);

U0 = zeros(size(im));


%--boundary conditions----------------------------------------------------



%---finite difference scheme----------------------------------------------

%Umax=max(max(U));
U_old = U0;
U_new = zeros(size(U_old));
for k = 1:size(ts,2)
    for i = 2:imX-1
        for j = 2:imY-1
           if(mask(i,j)==1)
               chi = 1;
           else
               chi = 0;
           end
    
               U_new(i,j) = r*(U_old(i+1,j)+U_old(i-1,j)+U_old(i,j+1) ...
                          + U_old(i,j-1))+(1-4*r)*U_old(i,j) ...
                          + dt*chi*(im(i,j)-U_old(i,j));
        end
    end
    U_old = U_new;
end

%--display image inpainted----------------------------------------------


imshow(im2uint8(U_new));

%------------------------------------------------------------------------





