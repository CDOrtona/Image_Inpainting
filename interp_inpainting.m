function [Irestored_linear, Irestored_nearest] = interp_inpainting(I,mask)

%La funzione permette di eseguire image inpainting su una foto in scala di
%grigi attraverso il metodo della interpolazione. In particolare e' stata
%implementata una funzione interpolante sia con il metodo lineare  sia con
%il metodo nearest neighbors.
%
%INPUT: 
%       I -> Immagine da restaurare
%       mask -> Maschera che definisce i punti(pixel) dell'immagine dove si 
%               ha il problema e dove si vuole quindi eseguire l'inpainting
%
%OUTPUT:
%       Irestored_linear -> Immagine restaurata con interpolazione lineare
%       Irestored_nearest ->Immagine restaurata con interpolazione Nearest
%                            Neighbour

[i, j] = find(mask == 1);
coord = cat(2,i,j);

[i2, j2] = find(mask ~= 1);
coordScat = cat(2, i2, j2);

ind = sub2ind(size(I), i, j);
indScat = sub2ind(size(I), i2, j2);

v = I(ind);

%Interpolante lineare
F_linear = scatteredInterpolant(coord, v, 'linear');
%Interpolante Nearest Neighbour 
F_nearest = scatteredInterpolant(coord, v, 'nearest');

%Definisico due diverse immagini ricostruite secondo i due metodi sopra
%definiti: lineare e Nearest neighbour
reconstructedImage_linear = I;
reconstructedImage_nearest = I;

%Faccio l'interpolazione lineare dei punti dell'immagine in cui vuole 
%eseguire l'inpainting
newV = F_linear(coordScat);
reconstructedImage_linear(indScat) = newV;

%Faccio l'interpolazione nearest neighbor dei punti dell'immagine in cui  
%vuole eseguire l'inpainting
newV = F_nearest(coordScat);
reconstructedImage_nearest(indScat) = newV;

%output delle immagini restaurate
Irestored_linear = reconstructedImage_linear;
Irestored_nearest = reconstructedImage_nearest;

end