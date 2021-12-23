clear;
close all;
clc;

% Questo programma permette di eseguire la restaurazione di una immagine
% (image inpainting) con il metodo dell'interpolazione o per 
% diffusione attraverso la risoluzione di una PDE.

%% Come usare il programma
% 
% All'avvio del programma viene chiesto di selezionare la maschera e
% successivamente selezionare l'immagine da restaurare.
% L'algoritmo funziona sia con immagini in scala di grigio che con immagini
% a colori.
%
% Per poter usare il programma si deve scegliere l'opzione di inpainting
% che si intende usare digitando sulla command window, una volta avviato il
% programma, il numero corrispondente ad una delle opzioni riportate qui
% di seguito:
%
% 1) Interpolazione
% 2) Parabolic PDE - Diffusion 
% 3) Exit



% ---------- Inizializzazione Immagini --------------------------------

mask = im2double(imread(uigetfile('*.jpg; *.png; *.bmp', "SCEGLI LA MASCHERA")));
im   = im2double(imread(uigetfile('*.jpg; *.png; *.bmp', "SCEGLI L'IMMAGINE DA RESTAURARE")));
inpainted_image = zeros(size(im));

%----------------Image Inpainting---------------------------------------

while 1
    switch input("Seleziona una di queste opzioni: \n " + ...
            " 1) Interpolazione \n " + ...
            " 2) PDE Diffusione\n " + ...
            " 3) Exit \n ")
    
        case 1
            
            % 1) Interpolazione
            %image inpainting nel caso di una immagine in scala di grigi
            if(size(im,3) == 1)
                figure
                [inpainted_image_L, inpainted_image_N] = interp_inpainting(im, mask);
                figure;
                subplot(1,3,1);
                imshow(im);
                title('Image to be inpainted');
                subplot(1,3,2);
                imshow(inpainted_image_L);
                title('Linear Interpolation Inpainting');
                subplot(1,3,3);
                imshow(inpainted_image_N);
                title('Nearest Neighbors Interpolation inpainting');
            
            else
                %image inpainting nel caso di una immagine RGB
                [im_R_L, im_R_N] = interp_inpainting(im(:,:,1), mask);
                [im_G_L, im_G_N] = interp_inpainting(im(:,:,2), mask);
                [im_B_L, im_B_N] = interp_inpainting(im(:,:,3), mask);
                inpainted_image_L = cat(3, im_R_L, im_G_L, im_B_L);
                inpainted_image_N = cat(3, im_R_N, im_G_N, im_B_N);
                subplot(1,3,1);
                imshow(im);
                title('Image to be inpainted');
                subplot(1,3,2);
                imshow(inpainted_image_L);
                title('Linear Interpolation Inpainting');
                subplot(1,3,3);
                imshow(inpainted_image_N);
                title('Nearest Neighbour Interpolation Inpainting');
            end

        case 2
            % 2) PDE 
            if(size(im,3) == 1)
                RGB = 0;
                inpainted_image = PDE_inpainting(im,mask, RGB);
            else 
                RGB = 1;
                im_R_L = PDE_inpainting(im(:,:,1),mask, RGB);
                im_G_L = PDE_inpainting(im(:,:,2),mask, RGB);
                im_B = PDE_inpainting(im(:,:,3),mask, RGB);
                inpainted_image = cat(3, im_R_L, im_G_L, im_B);
            end

            figure;
            montage({im, im2uint8(inpainted_image)});
            title(['Image to Be Inpainted','    |    ','PDE Inpainted Image']);
            
        case 3
            %exit
            break

        otherwise
            %caso in cui si digita un numero non compreso in elenco
            disp('Carattere non riconosciuto');
    end
end



