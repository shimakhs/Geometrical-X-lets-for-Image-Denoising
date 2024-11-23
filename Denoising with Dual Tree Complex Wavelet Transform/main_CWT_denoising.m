 clear all; close all; clc;
% read the image
f = imread('boat.png');
f = double(f);
% Add noise
Sigma =25;
NN = Sigma*randn(size(f));
f1 = f + NN;
% save ('lena10','f1')
% f1 = load('lena70.mat');
% f1 = struct2cell(f1);
% f1 = cell2mat(f1);
figure;imshow(f,[]);
figure;imshow(f1,[]);title('noisy image')
%% Denoising using 2D-CWT
method = 's';        % method could be 's'/'h' denotes for soft/hard thresholding
f2 = CWT_2D_denoise(f1,Sigma,method); 
figure,                                                                                                                                                                                                                                                             
imshow(f2,[]),title('Denoised image')
f3 = (f2-min(min(f2)))/max(max(f2)-min(min(f2)));
f5 = (f1-min(min(f1)))/max(max(f1)-min(min(f1)));
f4 = (f-min(min(f)))/max(max(f)-min(min(f)));

P_nosisy = psnr(f4,f5);
p1_denosied = psnr(f4,f3);
% P_nosisy = psnr(f,f1);
% p1_denosied = psnr(f,f2);
%% calculating SSIM
K = [0.01 0.03];
window = fspecial('gaussian', 11, 1.5);
L = 1;
[ssim_noisy, ssim_map] = ssim(f4, f5 , K, window, L);
[ssim_denoised, ssim_map2] = ssim(f4, f3, K, window, L);
