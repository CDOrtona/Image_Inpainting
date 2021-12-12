
%------------------------------------------------------------------------
%--- Heat Equation in two dimensions-------------------------------------
%--- Solves Ut=alpha*(Uxx+Uyy)-------------------------------------------
%------------------------------------------------------------------------

clc;
close all;
clear;

<<<<<<< Updated upstream
%--image------------------------------------------------------------------
=======
%--image loading------------------------------------------------------------------
>>>>>>> Stashed changes

mask_file = uigetfile('*.jpg; *.png; *.bmp', "Select the mask");
image_file = uigetfile('*.jpg; *.png; *.bmp', "Select the image");
mask = im2double(imread(mask_file));
im = im2double(imread(image_file));

%im = im2double(imread('parrot.png', 'png'));
%mask = im2double(imread('parrot-mask.png', 'png'));
<<<<<<< Updated upstream
[imX, imY] = size(im);

%--dimensions...........................................................

DX=1; % step size
DY=1;
Nx=imX; 
Ny=imY;


alpha=3; % arbitrary thermal diffusivity 

%--initial condition------------------------------------------------------

inds = find(mask == 0);
[rows, cols] = ind2sub(size(mask),inds);
rowsCols = cat(2, rows, cols);
%U(coord_damaged_pixels') = im(coord_damaged_pixels');



%--boundary conditions----------------------------------------------------

im1 = im;
U = im1;

%-------------------------------------------------------------------------

%DT = DX^2/(2*alpha); % time step 
DT = 0.01;
r = alpha*(DT/DX^2); %it has to be less than 0.5 to have stability

M=10000; % maximum number of allowed iteration

%---finite difference scheme----------------------------------------------

Ncount=0;
Umax=max(max(U));
loop=1;
while loop==1
   ERR=0; 
   U_old = U;
    for i = 2:imX-1
        for j = 2:imY-1
           if(mask(i,j)==0)
    
               Residue = r*U_old(i+1,j)+(1-4*r)*U_old(i,j)+r*U_old(i-1,j)... 
                                  + r*U_old(i,j+1)+r*U_old(i,j-1)-U(i,j);
               U(i,j) = Residue + U(i,j);
               ERR=ERR+abs(Residue);
           end
        end
    end

    if(ERR>=0.01*Umax)  % allowed error limit is 1% of maximum temperature
        Ncount=Ncount+1;
     
     %--if solution do not converge in 2000 time steps--------------------
     
        if(Ncount>M)
            loop=0;
            disp(['solution do not reach steady state in ',num2str(M),...
                'time steps'])
        end
        
     %--if solution converges within 2000 time steps......................
        
    else
        loop=0;
        disp(['solution reaches steady state in ',num2str(Ncount) ,'time steps'])
    end
end

%--display image inpainted----------------------------------------------


imshow(U);
figure
imshow(im);
=======
[im_x, im_y] = size(im);

%--parameters set-up...........................................................

alpha=0.5; % arbitrary thermal diffusivity 

DX=1; % step size 
DY=1;

t_max = 400;
%DT = 0.025;
DT = 0.1;
r = alpha*(DT/DX^2); %it has to be less than 0.5 to have stability

ts = 0:DT:t_max;
ts_n = length(ts); %number of nodes in the time domain

%--initial condition------------------------------------------------------

U0 =  zeros(size(im));

%--boundary conditions----------------------------------------------------



%---Explicit PDE Heat Diffusion-------------------------------------------

ind = find(mask == 0);
im_new = im;
im_new(ind) = rand(nnz(ind),1);

imshow(im_new);
figure;

Umax=max(max(U0));
U_new = zeros(size(im));
U_old = U0;

for k = 1:ts_n

    for i = 2:im_x-1

        for j = 2:im_y-1

           if(mask(i,j)==1)
               chi = 1;
           else
               chi = 0;
           end

           U_new(i,j) = r*(U_old(i+1,j)+U_old(i-1,j)+U_old(i,j+1) ...
                      + U_old(i,j-1))+(1-4*r)*U_old(i,j)  ... 
                      + chi*DT*(im(i,j)-U_old(i,j));
             
        end
    end

    U_old = U_new;
end

%--display image inpainted----------------------------------------------
restored_image = im2uint8(U_new);
imshow(restored_image);
>>>>>>> Stashed changes

%------------------------------------------------------------------------





