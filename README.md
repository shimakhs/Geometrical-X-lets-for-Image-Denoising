# Geometrical-X-lets-for-Image-Denoising
# Synthetic OCT Denoising using Various Transform Techniques

This repository contains MATLAB code for denoising synthetic Optical Coherence Tomography (OCT) images. The code applies different X-let transform techniques to remove speckle noise from synthetic OCT images, including Curvelet Transform, Steerable Pyramids, Discrete Wavelet Transform (DWT), Complex Wavelet Transform (CWT), and Contourlet Transform.

## Files

### 1. `main_circlet_OCT_synthetic.m`
This script reads a synthetic OCT image, applies speckle noise, and performs logarithmic transformation. It then denoises the image using Circlet transform and calculates the PSNR (Peak Signal-to-Noise Ratio) and SSIM (Structural Similarity Index) for the noisy and denoised images.
- **Dependencies**: `circlet_denoising1.m`
- **Outputs**: Original, noisy, and denoised images; PSNR and SSIM metrics.

### 2. `circlet_denoising1.m`
This function performs denoising on the input image using the Circlet transform with soft or hard thresholding. It applies a frequency domain thresholding method to reduce noise and reconstruct the image.
- **Parameters**:
  - `f`: Input noisy image.
  - `N`: Number of filters for the CT.
  - `r0`: Radius range for candidate circles.
  - `Sigma`: Noise standard deviation.
  - `method`: Thresholding method (`'s'` for soft, `'h'` for hard).
- **Outputs**: Denoised image.

### 3. `main_Curvelet_OCT_synthetic.m`
This script follows a similar workflow as `main_circlet_OCT_synthetic.m`, but applies the Curvelet Transform for denoising. The synthetic OCT image is denoised using a Curvelet-based method and the PSNR and SSIM metrics are computed.
- **Dependencies**: `curvelet_denoise.m`
- **Outputs**: Original, noisy, and denoised images; PSNR and SSIM metrics.

### 4. `curvelet_denoise.m`
This function applies the Curvelet Transform and soft thresholding to denoise the image. The Curvelet transform decomposes the image into subbands, and thresholding is applied based on noise standard deviation.
- **Parameters**:
  - `f`: Input noisy image.
  - `Sigma`: Noise standard deviation.
  - `method`: Thresholding method (`'s'` for soft).
- **Outputs**: Denoised image.

### 5. `main_steerable_OCT_synthetic.m`
This script uses the Steerable Pyramid Transform to denoise the synthetic OCT image. The script follows a similar process of adding noise, logarithmic transformation, and denoising with the Steerable Pyramid method.
- **Dependencies**: `steerable_denoise.m`
- **Outputs**: Original, noisy, and denoised images; PSNR and SSIM metrics.

### 6. `steerable_denoise.m`
This function implements denoising based on the Steerable Pyramid Transform. It uses soft thresholding for each scale and orientation in the pyramid and reconstructs the denoised image.
- **Parameters**:
  - `f`: Input noisy image.
  - `Sigma`: Noise standard deviation.
  - `method`: Thresholding method (`'s'` for soft).
- **Outputs**: Denoised image.

### 7. `main_DWT_OCT_synthetic.m`
This script performs denoising using the 2D Discrete Wavelet Transform (DWT). The script adds speckle noise, applies logarithmic transformation, and then denoises the image with DWT. It calculates PSNR and SSIM metrics for the noisy and denoised images.
- **Dependencies**: `DWT_2D_denoise.m`
- **Outputs**: Original, noisy, and denoised images; PSNR and SSIM metrics.

### 8. `DWT_2D_denoise.m`
This function applies the 2D Discrete Wavelet Transform (DWT) to the noisy image and uses soft thresholding to reduce noise. The image is reconstructed using the inverse DWT after thresholding.
- **Parameters**:
  - `f`: Input noisy image.
  - `Sigma`: Noise standard deviation.
  - `method`: Thresholding method (`'s'` for soft).
- **Outputs**: Denoised image.

### 9. `main_CWT_OCT_synthetic.m`
This script applies the dual tree Complex Wavelet Transform (DT-CWT) for denoising synthetic OCT images. It follows the same workflow as the other scripts but uses CWT for denoising and calculates PSNR and SSIM metrics.
- **Dependencies**: `CWT_2D_denoise.m`
- **Outputs**: Original, noisy, and denoised images; PSNR and SSIM metrics.

### 10. `CWT_2D_denoise.m`
This function uses the dual tree Complex Wavelet Transform (DT-CWT) for denoising. It applies soft thresholding to each scale and subband of the CWT coefficients to reduce noise.
- **Parameters**:
  - `f`: Input noisy image.
  - `Sigma`: Noise standard deviation.
  - `method`: Thresholding method (`'s'` for soft).
- **Outputs**: Denoised image.

### 11. `main_Contourlet_OCT_synthetic.m`
This script applies the Contourlet Transform for denoising. It performs the same operations as the other scripts, including adding noise, applying logarithmic transformation, and denoising using the Contourlet Transform.
- **Dependencies**: `contourlet_denoise.m`
- **Outputs**: Original, noisy, and denoised images; PSNR and SSIM metrics.

### 12. `contourlet_denoise.m`
This function applies the Contourlet Transform for denoising the input image. Soft thresholding is used to remove noise from the coefficients at each scale and orientation.
- **Parameters**:
  - `f`: Input noisy image.
  - `Sigma`: Noise standard deviation.
  - `method`: Thresholding method (`'s'` for soft).
- **Outputs**: Denoised image.



