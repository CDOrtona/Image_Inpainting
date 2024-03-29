clear;
close all;
clc;

% ---------- Image initialization --------------------------------

mask = im2double(imread(uigetfile('*.jpg; *.png; *.bmp', "Choose the mask")));
im   = im2double(imread(uigetfile('*.jpg; *.png; *.bmp', "Choose the image to restore")));
inpainted_image = zeros(size(im));

%----------------Image Inpainting---------------------------------------

while 1
    switch input("Choose one of the following options: \n " + ...
            " 1) Interpolation \n " + ...
            " 2) Liner Diffusion\n " + ...
            " 3) Exit \n ")
    
        case 1
            
            % 1) Interpolation
            %image inpainting for gray-scale images
            if(size(im,3) == 1)
                figure
                [inpainted_image_L, inpainted_image_N] = interp_inpainting(im, mask);            
            else
                %image inpainting for RGB images
                [im_R_L, im_R_N] = interp_inpainting(im(:,:,1), mask);
                [im_G_L, im_G_N] = interp_inpainting(im(:,:,2), mask);
                [im_B_L, im_B_N] = interp_inpainting(im(:,:,3), mask);
                inpainted_image_L = cat(3, im_R_L, im_G_L, im_B_L);
                inpainted_image_N = cat(3, im_R_N, im_G_N, im_B_N);
            end

            figure
            subplot(1,3,1);
            imshow(im);
            title('Image to be inpainted');
            subplot(1,3,2);
            imshow(inpainted_image_L);
            title('Linear Interpolation');
            subplot(1,3,3);
            imshow(inpainted_image_N);
            title('Nearest Neighbors Interpolation');

        case 2
            % 2) Linear PDE 
            if(size(im,3) == 1)
                inpainted_image = PDE_inpainting(im,mask);
            else 
                im_R_L = PDE_inpainting(im(:,:,1),mask);
                im_G_L = PDE_inpainting(im(:,:,2),mask);
                im_B = PDE_inpainting(im(:,:,3),mask);
                inpainted_image = cat(3, im_R_L, im_G_L, im_B);
            end

            figure;
            subplot(1,2,1);
            imshow(im);
            title("Image to Be Inpainted");
            subplot(1,2,2);
            imshow(inpainted_image);
            title("PDE - Inpainted Image");

            
        case 3
            %exit
            break

        otherwise
            disp('Unrecognized option');
    end
end



