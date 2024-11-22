function y = DWT_2D_denoise(f,Sigma,method)
%% apply DWT
f = double(f);
[af, sf] = farras;
J =6;
Nsig = Sigma;

w = dwt2D(f,J,af);
% loop thru scales:
for j = 1:J
%     loop thru subbands    
    for s = 1:3
                Ssig{j}{s} = sqrt(max((std2(w{j}{s})^2-Nsig^2),eps));
                Thresh{j}{s} = 1.4*(Nsig^2)/Ssig{j}{s};
                w{j}{s} = wthresh(w{j}{s},'s', Thresh{j}{s});
%         w{j}{s} = wthresh(w{j}{s},'s',T);
    end
end
y = idwt2D(w,J,sf);