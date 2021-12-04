
%------------------------------------------------------------------------
%--- Heat Equation in two dimensions-------------------------------------
%--- Solves Ut=alpha*(Uxx+Uyy)-------------------------------------------
%------------------------------------------------------------------------

clc;
close all;
clear;

%--image------------------------------------------------------------------

mask_file = uigetfile('*.jpg; *.png; *.bmp', "Select the mask");
image_file = uigetfile('*.jpg; *.png; *.bmp', "Select the image");
mask = im2double(imread(mask_file));
im = im2double(imread(image_file));

%im = im2double(imread('parrot.png', 'png'));
%mask = im2double(imread('parrot-mask.png', 'png'));
[imX, imY] = size(im);

%--dimensions...........................................................

%N = 51;  
DX=1; % step size
DY=1;
Nx=imX; 
Ny=imY;

%X=0:DX:Nx;
%Y=0:DY:Ny;

%U = zeros(size(im));

alpha=3; % arbitrary thermal diffusivity 

%--initial condition------------------------------------------------------

%U(23:29,23:29)=0; % a heated patch at the center
[x_damage,y_damage] = find(mask == 0);
coord_damaged_pixels = sub2ind(size(mask),x_damage,y_damage);
%U(coord_damaged_pixels') = im(coord_damaged_pixels');



%--boundary conditions----------------------------------------------------

im1 = im;
im1(coord_damaged_pixels) = 0;
U = im1;

%-------------------------------------------------------------------------

%DT = DX^2/(2*alpha); % time step 
DT = 0.1;
r = alpha*(DT/DX^2); %it has to be less than 0.5 to have stability

M=5000; % maximum number of allowed iteration

%---finite difference scheme----------------------------------------------

fram=0;
Ncount=0;
Umax=max(max(U));
loop=1;
while loop==1
   ERR=0; 
   U_old = U;
    for i = 2:imX-1
        for j = 2:imY-1
           if(im1(i,j) == 0)
    
               Residue = r*U_old(i+1,j)+(1-4*r)*U_old(i,j)+r*U_old(i-1,j)... 
                                  + r*U_old(i,j+1)+r*U_old(i,j-1)-U(i,j);
               ERR=ERR+abs(Residue);
               U(i,j)=U(i,j)+Residue;
    
           end
        end
    end
    
    if(ERR>=0.01*Umax)  % allowed error limit is 1% of maximum temperature
        Ncount=Ncount+1;
             if (mod(Ncount,50)==0) % displays movie frame every 50 time steps
                  fram=fram+1;
                  surf(U);
                  axis([1 imX 1 imY ])
                  h=gca; 
                  get(h,'FontSize') 
                  set(h,'FontSize',12)
                  colorbar('location','eastoutside','fontsize',12);
                  xlabel('X','fontSize',12);
                  ylabel('Y','fontSize',12);
                  title('Heat Diffusion','fontsize',12);
                  fh = figure(1);
                 set(fh, 'color', 'white'); 
                F=getframe;
             end
     
     %--if solution do not converge in 2000 time steps------------------------
     
        if(Ncount>M)
            loop=0;
            disp(['solution do not reach steady state in ',num2str(M),...
                'time steps'])
        end
        
     %--if solution converges within 2000 time steps..........................   
        
    else
        loop=0;
        disp(['solution reaches steady state in ',num2str(Ncount) ,'time steps'])
    end
end

%--display image inpainted----------------------------------------------

[b,a] = size(im);
[X,Y] = meshgrid(1:a, 1:b);
surf(X,Y,U);
figure
imshow(U);
figure

%------------------------------------------------------------------------
%--display a movie of heat diffusion------------------------------------

 movie(F,fram,1)

%------END---------------------------------------------------------------




