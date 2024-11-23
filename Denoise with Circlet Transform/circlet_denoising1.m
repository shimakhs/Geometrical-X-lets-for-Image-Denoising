function y = circlet_denoising(f,N,r0,Sigma,method)
%% apply FCT
f = double(f);
[Cl, Gkw] = fdct2(f, N, r0, 'complex'); 
%% calculate threshold for each subband
Nsig = Sigma;
%% Modify coefficients
method = 's'; 
c = [1,3,4];
for x=1:size(Cl,1)%%% in ra taghiiiiir dadam va az 2 shoru kardam
%     for y=2:size(Cl,2) 
%      for y=1:size(Cl,2)-1 
         for y=1:3
        rel{x,c(y)}(:,:) = (real(Cl{x,c(y)}(:,:)));
        img{x,c(y)}(:,:) = (imag(Cl{x,c(y)}(:,:)));
    end
end
%%%%%%%%
%%%%%%%%%%%%%%%%%%
for x=1:size(Cl,1) %%% in ra taghiiiiir dadam va az 2 shoru kardam
%     for y=2:size(Cl,2) 
%     for y=1:size(Cl,2)-1 
         for y=1:3
        Ssig_rel(x,c(y)) = sqrt( max((std2(rel{x,c(y)})^2-Nsig^2),eps));
        Thresh_rel(x,c(y)) = (Nsig^2)/Ssig_rel(x,c(y));
        Ssig_img(x,c(y)) = sqrt( max((std2(img{x,c(y)})^2-Nsig^2),eps));
        Thresh_img(x,c(y)) = (Nsig^2)/Ssig_img(x,c(y));
        
        Cln1{x,c(y)} = wthresh(rel{x,c(y)},method,Thresh_rel(x,c(y)));
        Cln2{x,c(y)} = wthresh(img{x,c(y)},method,Thresh_img(x,c(y)));
Cln{x,c(y)}=Cln1{x,c(y)}+ sqrt(-1)*Cln2{x,c(y)};

    end
end

     for x=1:size(Cl,1)
         Cln{x,2} = Cl{x,2};

     end
     
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
y = abs(ifdct2(Cln, Gkw));