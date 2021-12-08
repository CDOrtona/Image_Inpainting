clear;
close all;
clc;

% Questo semplice programma scritto in Matlab permette di eseguire image
% inpainting con due metodi distinti:
% 1) Interpolazione
% 2) Parabolic PDE - Heat Diffusion 

% ---------- Inizializzazione Immagini --------------------------------

mask = im2double(imread(uigetfile('*.jpg; *.png; *.bmp', "Choose the mask")));
im   = im2double(imread(uigetfile('*.jpg; *.png; *.bmp', "Choose the image")));

while 1
    switch input("Choose your option: \n " + ...
            " 1) Interpolazione \n " + ...
            " 2) PDE Heat-Diffusion \n " + ...
            " 3) Exit \n ")
    
        case 1
         
            % 1) Interpolazione
            inpainted_image = interp_inpainting(im, mask);
    
            montage({im, inpainted_image});
            title(['Image to Be Inpainted','    |    ','Inpainted Image']);
            
        case 2
            % 2) PDE 
    
        case 3
            break
    end
end




