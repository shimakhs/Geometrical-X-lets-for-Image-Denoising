clear all; close all; clc;
%% read the image
I = imread('average.tif'); % synthetic OCT
I1 = imresize(I,[256 256]);
Sigma = 0.2;
mn1 = imnoise(I1,'speckle',Sigma^2); % addind speckle noise 
I1 = double(I1);
mn1 = double(mn1);
figure; imshow(I1,[]);title('original synthetic image')
figure; imshow(mn1,[]);title('noisy image(speckle)')
%% logarithm transform
xs = log(mn1 + 1);
figure; imshow(xs,[]);title('logarithm of noisy image')
%% Denoising using 2D-DWT
method = 's';        % method could be 's'/'h' denotes for soft/hard thresholding
f2 = CWT_2D_denoise(xs,Sigma,method); 
f2= exp(f2);
figure,                                                                                                                                                                                                                                                             
imshow(f2,[]),title('Denoised image')
I11 = (I1-min(min(I1)))/max(max(I1)-min(min(I1))); % original
mn11= (mn1-min(min(mn1)))/max(max(mn1)-min(min(mn1))); % noisy logarithm
f22 = (f2-min(min(f2)))/max(max(f2)-min(min(f2))); % denoised

P_noisy = psnr(I11,mn11);
p_denosied = psnr(I11,f22);

%% calculating SSIM
K = [0.01 0.03];
window = fspecial('gaussian', 11, 1.5);
L = 1;
[ssim_noisy, ssim_map] = ssim(I11,mn11 , K, window, L);
[ssim_denoised, ssim_map2] = ssim(I11,f22, K, window, L);
