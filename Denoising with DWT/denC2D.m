function y = denC2D(x,T);

% % Example
% clc; clear all; close all
% s1 = imread('boat.png');
% figure; imshow(s1,[]);
%  %  s = s1(:,:,3);
% % x = s1 + 20*randn(size(s1));
% x = imnoise(s1,'Gaussian',0,0.01);
% figure; imshow(x,[])
% x = double(x);
% T = 40;
% y = denC2D(x,T);
% figure; imagesc(y)
% colormap(gray)
% axis image
% origImg = x;
% distImg = y;
% PSNR = psnr(distImg, origImg)
% sqrt(mean(mean((y-s1).^2)))

[Faf, Fsf] = FSfarras;
[af, sf] = dualfilt1;
J = 4;
w = cplxdual2D(x,J,Faf,af);
I = sqrt(-1);
% loop thru scales:
for j = 1:J
    % loop thru subbands
    for s1 = 1:2
        for s2 = 1:3
            C = w{j}{1}{s1}{s2} + I*w{j}{2}{s1}{s2};
            C = wthresh(C,'s',T);
            w{j}{1}{s1}{s2} = real(C);
            w{j}{2}{s1}{s2} = imag(C);
        end
    end
end
y = icplxdual2D(w,J,Fsf,sf);
