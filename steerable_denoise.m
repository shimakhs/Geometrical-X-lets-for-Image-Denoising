function y = steerable_denoise(f,Sigma,method)
ht = 3;
Nsig = Sigma;
coeff=buildSpyr(f,ht,'sp3.mat');
for j =2:ht-1
    for i = 1:4
        Ssig{1,j}{1,i} = sqrt(max( ((std2(coeff{1,j}{1,i}))^2-Nsig^2),eps));
         Thresh{1,j}{1,i}= (0.2*Nsig^2)/Ssig{1,j}{1,i};
         coeff{1,j}{1,i} = wthresh(coeff{1,j}{1,i},method, Thresh{1,j}{1,i});
           end 
end
Ssig{1,1} = sqrt(max( ((std2(coeff{1,1}))^2-Nsig^2),eps));
Thresh{1,1}= (0.2*Nsig^2)/Ssig{1,1};
coeff{1,1} = wthresh(coeff{1,1},'s',Thresh{1,1});
y =reconSpyr(coeff,'sp3.mat');
