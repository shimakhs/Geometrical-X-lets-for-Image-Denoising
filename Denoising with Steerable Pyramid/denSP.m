function y = denSP(x,T)
ht = 3;
coeff=buildSpyr(x,ht,'sp3.mat');
for j = 2:ht-1
    for i = 1:4
    coeff{1,j}{1,i} = wthresh(coeff{1,j}{1,i},'s',T);
    end 
end
coeff{1,1} = wthresh(coeff{1,1},'s',T);
y =reconSpyr(coeff,'sp3.mat');
    
