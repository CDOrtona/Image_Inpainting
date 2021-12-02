clear 
clc
close all

mask_file = uigetfile('*.jpg; *.png; *.bmp', "Select the mask");
image_file = uigetfile('*.jpg; *.png; *.bmp', "Select the image");
mask = im2double(imread(mask_file));
image = im2double(imread(image_file));

tic
[i, j] = find(mask == 1);
coord = cat(2,i,j);


%this finds the coodrinates of matrix value that are equal to 0, hence
%where there is the problem
[i2, j2] = find(mask ~= 1);
coordScat = cat(2, i2, j2);

%sub2ind converts the coordinates of the rows and columns to indices which
%will be used for linear indexing of the matrix containing the value of the
%image we wish to interpolate
ind = sub2ind(size(image), i, j);
indScat = sub2ind(size(image), i2, j2);

v = image(ind');

%I HAVE TO CHOOSE A METHOD
F = scatteredInterpolant(coord, v', 'linear');

reconstructedImage = image;
reconstructedImage(indScat') = 0;

%subplot(1,2,1);
imshow(reconstructedImage);
title("Highlighted Scattered Data");

newV = F(coordScat);
reconstructedImage(indScat') = newV';

figure
montage({image, reconstructedImage});
title(['Image to Be Inpainted','    |    ','Inpainted Image']);
t = toc;
display(t);

