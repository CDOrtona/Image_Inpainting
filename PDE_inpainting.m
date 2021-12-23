function [Irestored, peaksnr] = PDE_inpainting(I, mask, RGB)

% Questa funzione permette di effettuare image inpainting attraverso la
% soluzione di una PDE simile all'equazione del calore. La regione regione
% dove è presente il problema è ricostruita per diffusione.

% INPUT: 
%        I -> Immagine da restaurare
%        mask -> Maschera che definisce i punti(pixel) dell'immagine dove si 
%                ha il problema e dove si vuole quindi eseguire l'inpainting
%        RGB -> E' uguale ad 1 nel caso in cui l'immagine da restaurare è a
%               colori e non in scala di grigi
% OUTPUT 
%        Irestored -> Immagine restaurata
%        peaksnr -> PSNR calcolato sull'immagine Irestored

[imX, imY] = size(I);

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
chi_ind = mask == 1;
chi(chi_ind) = 1;

U_old = U0;
U_new = size(U_old);

for k = 1:ts_n
    
    U_new = U_old+L_X*U_old+U_old*L_Y+dt*(chi.*(I-U_old));
    U_old = U_new;
    
    %Nel caso l'immagine è a colori evito di mostrare graficamente la
    %diffusione della zona su cui fare inpainting, altrimenti impiegherebbe
    %troppo tempo l'algoritmo
    if RGB ~= 1
        figure(1);
        imagesc(U_new,[0 1]), axis equal; axis off; colormap(gray)
        title([num2str(k) 'timesteps'])
    end

end

Irestored = U_new;

%PSNR
Irestored = im2uint8(Irestored);
I = im2uint8(I);
peaksnr = psnr(Irestored,I);


end