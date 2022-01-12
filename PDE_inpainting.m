function [Irestored] = PDE_inpainting(I, mask)


% This function implements a simple image inpainting technique by solving a 
% linear PDE, derived from the heat equation, with the explicit method.
% Moreover the Neumann border conditions were observed in order to have a 
% correct inpainting along the borders of the image.

% INPUT: 
%        I -> Image to be inpainted
%        mask ->  The mask defines the pixels of the image corresponding to  
%                 the damaged regions we wish to inpaint.
% OUTPUT:
%        Irestored -> Restored image
%        

[imX, imY] = size(I);

dx=1; 
%dy=1;
dt = 0.4; 
t_max = 600; 

ts = 1:dt:t_max;
ts_n = size(ts,2);

lambda = 0.5;

r = lambda*(dt/dx^2); 

U0 = zeros(size(I));

L_X=(diag(-2*r*ones(imX,1)) + diag(r*ones(imX-1,1),1) + diag(r*ones(imX-1,1),-1));
L_Y=(diag(-2*r*ones(imY,1)) + diag(r*ones(imY-1,1),1) + diag(r*ones(imY-1,1),-1));

%Neumann conditions
L_X(1,2)=2*r;
L_X(imX,imX-1)=2*r;
L_Y(1,2)=2*r;
L_Y(imY,imY-1)=2*r;

chi = zeros(size(mask));
chi_ind = mask == 1;
chi(chi_ind) = 1;

U_old = U0;
U_new = size(U_old);

for k = 1:ts_n
    
    U_new = U_old+L_X*U_old+U_old*L_Y+dt*(chi.*(I-U_old));
    U_old = U_new;

end

%OUTPUT
Irestored = U_new;

end