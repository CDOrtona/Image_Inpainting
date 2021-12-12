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
inpainted_image = zeros(size(im));

%----------------Image Inpainting---------------------------------------

while 1
    switch input("Choose your inpainting option: \n " + ...
            " 1) Interpolazione \n " + ...
            " 2) PDE Heat-Diffusion \n " + ...
            " 3) Exit \n ")
    
        case 1
            
            % 1) Interpolazione
            if(size(im,3) == 1)
                inpainted_image = interp_inpainting(im, mask);
            else
                im_R = interp_inpainting(im(:,:,1), mask);
                im_G = interp_inpainting(im(:,:,2), mask);
                im_B = interp_inpainting(im(:,:,3), mask);
                inpainted_image = cat(3, im_R, im_G, im_B);
            end

            figure;
            montage({im, im2uint8(inpainted_image)});
            title(['Image to Be Inpainted','    |    ','Inpainted Image']);
            

        case 2
            % 2) PDE 
    
        case 3
            break
    end
end




