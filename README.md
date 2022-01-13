## Introduction

This is a fairly simple program that has been coded with the aim of performing image inpainting on damaged images. 
Two different techniques have been used:
1. Interpolation
2. Explicit solution of a linear PDE

The following image, used for this case study, has parts which have worn off over time. Those damaged regions are the ones we wish to inpaint and reconstruct. (In this repo you can find more example pictures which can be used to test the alghoritm).

<img src="https://github.com/CDOrtona/Image_Inpainting/blob/main/bebe.jpg" title="image to be inpainted" width="150"/>

The damaged regions are highlighted by the following mask:

<img src="https://github.com/CDOrtona/Image_Inpainting/blob/main/mask_bebe.bmp" title = "Mask" width = "150" />

## Interpolation

Those pixels of the input image, which show no sign of wear, have been modeled as scattered data and they have been used in order to define the interpolant. 
Two interpolants were defined: one for the linear interpolation and the other for the Nearest Neighbour interpolation. The output image obtained as a result of the algorithm is the following:

<img src="https://github.com/CDOrtona/Image_Inpainting/blob/main/Output/output_bebe_interpolation.png" title="Output Interpolation Algorithm" />

## Linear PDE

The second inpainting technique involves the solution of the following linear PDE using the explicit method.


 ![equation](http://www.sciweavers.org/tex2img.php?eq=u_t%20%3D%20%5Clambda%20%5CDelta%20u%20%2B%20%5Cchi_%7B%5COmega%20%5Csetminus%20D%7D%20%28f-u%29&bc=White&fc=Black&im=jpg&fs=12&ff=arev&edit=0)
 
 where
 
 ![equation](http://www.sciweavers.org/tex2img.php?eq=%5Cchi_%7B%5COmega%20%20%5Csetminus%20%20D%7D%28x%29%20%3D%5Cbegin%7Bcases%7D%20%28f-u%29%20%26%20x%20%20%5Cepsilon%20%5COmega%20%20%5Csetminus%20%20D%20%20%5C%5C0%20%26%20otherwise%5Cend%7Bcases%7D%20&bc=White&fc=Black&im=jpg&fs=12&ff=arev&edit=0)
 

Such PDE is similar to the heat equation and permits the inpainting of the image through an isotropic diffusion. 
A more in depth mathematical analysis of the problem can be found <a href="https://github.com/CDOrtona/Image_Inpainting/blob/main/doc/Doc-It.pdf"> Here </a>. (Please note that the doc is currently n Italian, the math part should be pretty straight forward though :laughing:

The result of the algorithm is the following: 

<img src="https://github.com/CDOrtona/Image_Inpainting/blob/main/Output/output_bebe_pde.png" title="Output PDE solution" />
 
 This PDE has two problems:
 1. It doesn't take into account damaged pixels which might be part of the borders
 2. The PDE solves performs an isotropic inpainting, hence the edges aren't taken into account.
 
 
### Neumann Condtions
The first issue has been addressed and solved by implementing the **Neumann boundary condition**.

As an example have a look at how an image would look witouth and with such boundary condition:

<img src=""/>


## Future Implementations

* Higher order non linear anisotropic PDE in order to take into account the edges 




