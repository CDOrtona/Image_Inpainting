<div align="center">
  <h1>Image Inpainting - PDE Linear Diffusion</h1>
  
<!-- Badges -->
<p>
  <a href="https://github.com/CDOrtona/Image_Inpainting/graphs/contributors">
    <img src="https://img.shields.io/github/contributors/Louis3797/awesome-readme-template" />
  </a>
  <a href="https://github.com/CDOrtona/Image_Inpainting/network/members">
    <img src="https://img.shields.io/github/forks/CDOrtona/Image_Inpainting" alt="forks" />
  </a>
  <a href="https://github.com/CDOrtona/Image_Inpainting/stargazers">
    <img src="https://img.shields.io/github/stars/CDOrtona/Image_Inpainting" alt="stars" />
  </a>
  <a href="https://github.com/CDOrtona/Image_Inpainting/blob/master/LICENSE">
    <img src="https://img.shields.io/github/license/CDOrtona/Image_Inpainting" alt="license" />
  </a>
</p>

<h4>
    <a href="https://github.com/CDOrtona/Image_Inpainting/blob/main/doc/Doc-It.pdf">Documentation(IT)</a>
</div>

<br />


<!-- Table of Content -->
# Table of Content
- [Introduction](#introduction)
- [Interpolation](#interpolation)
- [Linear PDE](#linear-pde)
  * [Neumann Boundary Condition](#neumann-boundary-condition)
- [Future Implementations](#future-implementations)
- [License](#license)

## Introduction


This is a fairly simple program that has been coded with the aim of performing image inpainting on damaged images and it works with both RGB and gray-scale images.
Two different techniques have been used:
1. Interpolation
2. Explicit solution of a linear PDE

The following image, used for this case study, has pixels which have worn off over time. Those damaged regions are the ones we wish to inpaint and reconstruct. (In this repo you can find more example pictures which can be used to test the algorithm).

<img src="https://github.com/CDOrtona/Image_Inpainting/blob/main/bebe.jpg" title="image to be inpainted" width="150"/>

The damaged regions are highlighted by the following mask:

<img src="https://github.com/CDOrtona/Image_Inpainting/blob/main/mask_bebe.bmp" title = "Mask" width = "150" />

## Interpolation

Those pixels of the input image, which show no sign of wear, have been modeled as scattered data and they have been used in order to define the interpolant. 
Two interpolants were defined: one for the linear interpolation and the other for the Nearest Neighbour interpolation. The output image obtained as a result of the algorithm is the following:

<img src="https://github.com/CDOrtona/Image_Inpainting/blob/main/Output/output_bebe_interpolation.png" title="Output Interpolation Algorithm" />

## Linear PDE

The second inpainting technique involves the solution of the following linear PDE using the explicit method.


<img src="https://latex.codecogs.com/svg.image?u_t&space;=&space;\lambda\Delta&space;u&space;&plus;&space;\chi_{\Omega&space;\setminus&space;D}(f-u)" title="u_t = \Lambda\Omega u + \chi_{\Omega \setminus D}(f-u)" />
 
 where
 
<img src="https://latex.codecogs.com/svg.image?\chi_{\Omega&space;&space;\setminus&space;&space;D}(x)&space;=\begin{cases}&space;(f-u)&space;&&space;x&space;&space;\epsilon&space;\Omega&space;&space;\setminus&space;&space;D&space;&space;\\0&space;&&space;otherwise\end{cases}&space;" title="\chi_{\Omega \setminus D}(x) =\begin{cases} (f-u) & x \epsilon \Omega \setminus D \\0 & otherwise\end{cases} " />
 

Such PDE is similar to the heat equation and permits the inpainting of the image through an isotropic diffusion. 
A more in depth mathematical analysis of the problem can be found <a href="https://github.com/CDOrtona/Image_Inpainting/blob/main/doc/Doc-It.pdf"> Here </a>. (Please note that the doc is currently n Italian, the math part should be pretty straight forward though :laughing:)

The result of the algorithm is the following: 

<img src="https://github.com/CDOrtona/Image_Inpainting/blob/main/Output/output_bebe_pde.png" title="Output PDE solution" />
 
 This PDE has two problems:
 1. It doesn't take into account damaged pixels which might be part of the borders.
 2. The PDE performs an isotropic inpainting, hence the edges aren't taken into account.
 
 
### Neumann Boundary Condition
The first issue has been addressed and solved by implementing the **Neumann boundary condition**.

As an example have a look at how an image would look without and with such boundary condition:

<img src="https://github.com/CDOrtona/Image_Inpainting/blob/main/output/output_parrot_rgb_no_boundary.png" title="PDE with NO Neumann boundary condition" width="750"/>

<img src="https://github.com/CDOrtona/Image_Inpainting/blob/main/output/output_parrot_rgb.png" title="PDE with Neumann boundary condition" />


## Future Implementations

* Higher order non linear anisotropic PDE in order to have a weighted, edge preserving diffusion along the edges.

## License

Distributed under the MIT License. See LICENSE.txt for more information.





