clc
close all
clear all

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%get OCT data%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%---------------------------------------- Topcon---------------------------
denoised = load('denoised_DWT.mat')%denoised image
% mn=ymax_DWT;
 noisy= load('noisy_image.mat')%noisy image
% mn1=f1;
% 
% 
% load([cd,'\Den_complex_',(FileName(1:end-4))])%denoised image by different method
% mn1_Nik = Im_den;
% 
% load([cd,'\Den_amini_Gauss_',(FileName(1:end-4))])
% mn1_Amini = Im_den;
% 
% load([cd,'\Den_Jorj_mulvarGauss5_',(FileName(1:end-4))])
% mn1_Jorj= Im_den;
% cd(oldFolder)

%--------------------------------------------------------------------------
%Saving the size of croped image for each subject:
%--------------------------------------------------------------------------
k=2;        % number of methods for comparision 
% ImgNum=size(image_number_all,2);  % number of slices
% ImgNum=2;

        Im(:,:,1,1)= noisy;
        Im(:,:,1,2)= denoised;

%         Im(:,:,count,2)= mn(:,:,count);
%         Im(:,:,count,3)= mn1_Amini(:,:,count);
%         Im(:,:,count,4)= mn1_Jorj(:,:,count);

% Im(:,:,1,1)=mn;
m = input('give the number of TP and EP ROIs/ an even number');
% if isempty(m)
%     m = 2;
% end
[s1, s2]= size(Im(:,:,1,1));
ROIs= zeros (s1,s2,3+m,ImgNum);
MSNR1 = zeros(ImgNum,k);
MSNR2 = zeros(ImgNum,k);
CNR = zeros(ImgNum,k);
ENL = zeros(ImgNum,k);
SSIM = zeros(ImgNum,k);
%%
for count=1:ImgNum
    %% Normalization
    for ii=1:k
        A= Im(:,:,count,ii);
        maxI=max(A(:));
        minI=min(A(:));
        A_norm=(Im(:,:,count,ii)-minI)./(maxI-minI);
        Im(:,:,count,ii)=A_norm.*255;
    end
    %% make label
    label = cell(k,1);
    label{1,1} = 'original image';
    label{2,1}=' denoised image';
%     label{3,1}='amini method';
%     label{4,1}='proposed method';

    %% show the images
    for i=1:k
        figure,imagesc(Im(:,:,count,i)), axis image; axis off;colormap gray
        title(label{i,1})
        pause()
    end

    %% get regions to calculate CNR and MSNR
    figure,h_im = imagesc(Im(:,:,count,1));colormap gray
    title('Please determine Noise ROI')
    e = imellipse;
    position = wait(e);
    BW_noise = createMask(e,h_im);
    ROIs(:,:,1,count)=BW_noise;

    title('Please determine Intralayer ROI')
    e = imellipse;
    position = wait(e);
    BW_Intralayer = createMask(e,h_im);
    ROIs(:,:,2,count)=BW_Intralayer;
% 

    title('Please determine SEAD ROI')
    e = imellipse;
    position = wait(e);
    BW_SEAD = createMask(e,h_im);
    ROIs(:,:,3,count)=BW_SEAD;

    for j=1:m/2    
        title('Please determine TP ROI')
        e = imellipse;
        position = wait(e);
        BW_TP(:,:,j) = createMask(e,h_im);
        ROIs(:,:,3+j,count)=BW_TP(:,:,j);
    end
    
    for jj=1:m/2    
        title('Please determine EP ROI')
        e = imellipse;
        position = wait(e);
        BW_EP(:,:,jj) = createMask(e,h_im);
        ROIs(:,:,3+(m/2)+jj,count)=BW_EP(:,:,jj);
    end
    %% calculate MSNR
    for i=1:k
        ROI_Noise = Im(:,:,count,i).*BW_noise;
        ROI1 = Im(:,:,count,i).* BW_Intralayer;
        ROI2 = Im(:,:,count,i).* BW_SEAD;

        ROI_Noise(~BW_noise)=[];
        ROI1(~BW_Intralayer)=[];
        ROI2(~BW_SEAD)=[];
% 
        MSNR1(count,i) = mean(ROI1(:))./std(ROI_Noise(:));
        MSNR2(count,i) = mean(ROI2(:))./std(ROI_Noise(:));
% 
        CNR(count,i) = abs(MSNR1(count,i)-MSNR2(count,i))
        
         CNR_Pizurika1(count,i) = 10*log(abs((mean(ROI1(:))-mean(ROI_Noise(:)))./sqrt(var(ROI_Noise(:))+var(ROI1(:)))))
         CNR_Pizurika2(count,i) = 10*log(abs((mean(ROI2(:))-mean(ROI_Noise(:)))./sqrt(var(ROI_Noise(:))+var(ROI2(:)))));

        ss=Im(:,:,count,i);
        SNR(count,i) = 20* log (max(ss(:))./std(ROI_Noise(:)));

        ENL(count,i) = ((mean(ROI_Noise(:))).^2)./var(ROI_Noise(:));
        
        %% Calculate SSIM
        %Given 2 test images img1 and img2, whose dynamic range is 0-255,
        %if dynamic range is different, you should change it in the ssim
        %according to function explains.
        [mssim, ssim_map] = ssim(Im(:,:,count,1), Im(:,:,count,i));
        SSIM (count,i) = mssim;

        %% Calculate EME
%         alpha=.2;
%         blockSize=64;
%         EME(count,i)=computeEME(Im(1:512,:,count,i),alpha,blockSize);

    end

     % for EP computation:
    %%a 3-by-3 filter approximating the shape of the two-dimensional Laplacian operator. 
    %%The parameter alpha controls the shape of the Laplacian and must be in the range 0.0 to 1.0. The default value for alpha is 0.2
    % alpha=0.2;
        %     LapIm(:,:,i) = imfilter(Im(:,:,i),h,'replicate');
    
    TPm = zeros(m/2,k);
    EPm = zeros(m/2,k);
    h = fspecial('laplacian');
    
    for i=1:k
        for j=1:m/2
                %% calculate texture preservation (TP)
                
            ROI_TP1 = Im(:,:,count,1).* BW_TP(:,:,j); %noisy image
            ROI_TP2 = Im(:,:,count,i).* BW_TP(:,:,j); % denoised image

            ROI_TP1(~BW_TP(:,:,j))=[];
            ROI_TP2(~BW_TP(:,:,j))=[];

%             TPm(j,i) = (var(ROI_TP2(:))./ var(ROI_TP1(:))).* sqrt(mean(ROI_TP2(:))./ mean(ROI_TP1(:)));
            NoisyImg=Im(:,:,count,1);
            DenImg=Im(:,:,count,i);
            TPm(j,i) = (var(ROI_TP2(:))./ var(ROI_TP1(:))).* sqrt(mean(DenImg(:))./ mean(NoisyImg(:)));

    %% EP Rahele

            ROI1_N = Im(:,:,count,1).* BW_EP(:,:,j);  %noisy image
            ROI1_N_Lap = imfilter(ROI1_N, h);

            ROI1 = Im(:,:,count,i).* BW_EP(:,:,j);   % denoised image
            ROI1_Lap = imfilter(ROI1, h);

            num = corr2((ROI1_N_Lap-mean(ROI1_N_Lap(:))),(ROI1_Lap-mean(ROI1_Lap(:))));
%             denum = sqrt(num.*corr2((ROI1_Lap-mean(ROI1_Lap(:))),(ROI1_Lap-mean(ROI1_Lap(:)))));
            denum = sqrt(corr2((ROI1_N_Lap-mean(ROI1_N_Lap(:))),(ROI1_N_Lap-mean(ROI1_N_Lap(:)))).*corr2((ROI1_Lap-mean(ROI1_Lap(:))),(ROI1_Lap-mean(ROI1_Lap(:)))));

            EPm(j,i)=num./denum; 
        end
    end
    TP_mean(count,:) = mean(TPm,1)
    EP_mean(count,:) = mean(EPm,1)
    
%     clear BW_noise BW_Intralayer BW_SEAD
%      figure;imshow(Im(:,:,count,2),[]);title('Niknezhad method');
%     figure;imshow(Im(:,:,count,3),[]);title('NL method');
%     figure;imshow(Im(:,:,count,4),[]);title('ANL method');
end
% CNR_Pizurika1
% MSNR1
% MSNR2
% SNR
TP_mean
EP_mean
MTP=mean(TP_mean)
MCNR=mean(CNR)
MEP=mean(EP_mean)
% ENL
% SSIM
% EME

% ROI=strcat('ROIsNL5_OCT_rand_',num2str(Subject));
CNRs=strcat('CNR_OCTrand_',num2str(Subject));
EP=strcat('EP_OCTrand_',num2str(Subject));
TP=strcat('TP_OCTrand_',num2str(Subject));

% oldFolder = cd('C:\Amini\Thesis\data\Topcon\Mydata2\Result2');
% oldFolder = cd('E:\zahra\PHD\Thesis\data\Topcon\Mydata2\Result2');
% save (ROI,'ROIs');
% save (CNRs,'CNR');
% save (EP,'EP_mean');
% save (TP,'TP_mean');
% cd(oldFolder)
