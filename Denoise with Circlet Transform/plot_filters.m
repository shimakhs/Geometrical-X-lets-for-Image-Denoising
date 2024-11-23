 clear all; close all; clc;
%%  inputs
N = 8;
r0 = (10:5:50); 
I = imread('lena.jpg');
f = double(I);
[sf1,sf2] = size(f);
%% plot Fk & sum(abs(Fk)^2)
w = linspace(-5*pi,5*pi,10*sf1);
for k = 1:N
    F{1,k} = Fk_final(w, N, k);
%      F1{1,k} = Fk(w, N, k)+Fk(w+k*pi, N, k)+Fk(w-k*pi, N, k);
    figure; plot(cell2mat(F(1,k)));ylim([0 1])
%         figure; plot(cell2mat(F1(1,k)))

end
    
FF = zeros(1,10*size(f,1));
for k = 1:N
    FF = FF + (abs(cell2mat(F(1,k)))).^2;
%         FF = FF + (abs(cell2mat(F1(1,k)))).^2;

end
figure; plot(FF);title('sigma of square of magnitude of Fk')
%%%%%%%%%%%%%%%%%% plot Gk& sum(abs(Gk)^2)
% w1_ = linspace(-pi,pi,sf1);
% w2_ = linspace(-pi,pi,sf2);
% w1 = repmat(w1_',1,sf2);
% w2 = repmat(w2_,sf1,1);
% absw = sqrt(w1.^2+w2.^2);
%    Gkw = cell(length(r0),N);
%     for k=1:N
%         for r=1:length(r0)
%             Gkw{r,k} = Gk(r0(r), N, k, sf1, sf2);
%         end
%     end
    %%%%%%%%%%%%%%%%%%%%%%%
%  
% figure; imshow(cell2mat(Gkw(1,1)));
% figure; imshow(cell2mat(Gkw(2,1)));
% figure; imshow(cell2mat(Gkw(3,1)));
% figure; imshow(cell2mat(Gkw(4,1)));

% 
% GG = zeros(sf1,sf2);
% for k = 1:N
%     GG = GG + (abs(cell2mat(Gkw(length(r0),k)))).^2;
% end
% figure; imshow(GG);title('sigma of square of magnitude of Gk')
    
    