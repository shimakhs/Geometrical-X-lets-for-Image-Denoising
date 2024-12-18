function y = CWT_2D_denoise(f,Sigma,method)
%% apply CWT
f = double(f);


[Faf, Fsf] = FSfarras;
[af, sf] = dualfilt1;
J = 6;
Nsig = Sigma;
w = cplxdual2D(f,J,Faf,af);
I = sqrt(-1);
% loop thru scales:
%%%%%%%
for j = 1:J
    % loop thru subbands
    for s1 = 1:2
        for s2 = 1:3
               C = w{j}{1}{s1}{s2} + I*w{j}{2}{s1}{s2};
               Ssig = sqrt( max((std2(C)^2-Nsig^2),eps));
               Thresh = (0.2*Nsig^2)/Ssig;
                C = wthresh(C,'s',Thresh);
                w{j}{1}{s1}{s2} = real(C);
                w{j}{2}{s1}{s2} = imag(C);
%         Ssig_rel{j}{1}{s1}{s2} = sqrt( max((std2(w{j}{1}{s1}{s2})^2-Nsig^2),eps));
%         Thresh_rel{j}{1}{s1}{s2} = (sqrt(2)*Nsig^2)/Ssig_rel{j}{1}{s1}{s2};
%         w{j}{1}{s1}{s2} = wthresh(w{j}{1}{s1}{s2},method,Thresh_rel{j}{1}{s1}{s2});
%         
%         Ssig_img{j}{2}{s1}{s2} = sqrt( max((std2(w{j}{2}{s1}{s2})^2-Nsig^2),eps));
%         Thresh_img{j}{2}{s1}{s2} = (sqrt(2)*Nsig^2)/Ssig_img{j}{2}{s1}{s2};
%         w{j}{2}{s1}{s2} = wthresh(w{j}{2}{s1}{s2},method,Thresh_img{j}{2}{s1}{s2});
        end
    end
end

y = icplxdual2D(w,J,Fsf,sf);

