function y = denS2D(x,T)

% % Example
% clc; close all; clear all
% s1 = imread('boat.png');
% figure; imshow(s1,[]);
% % s = s1(:,:,3);
% % x = s1 + 20*randn(size(s1));
% x = imnoise(s1,'Gaussian',0,0.01);
% figure; imshow(x,[])
% x = double(x);
% T = 10;
% y = denS2D(x,T);
% figure; imagesc(y)
% colormap(gray)
% axis image
% origImg = x;
% distImg = y;
% PSNR = psnr(distImg, origImg)

[af, sf] = farras;
J =6;
w = dwt2D(x,J,af);
% loop thru scales:
for j = 1:J
    % loop thru subbands
    for s = 1:3
        w{j}{s} = wthresh(w{j}{s},'s',T);
    end
end
y = idwt2D(w,J,sf);

% figure; bar(hist(cell2mat(w{1,1}),30),'b')