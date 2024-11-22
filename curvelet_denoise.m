function y = curvelet_denoise(f,Sigma,method)
% Parameters
Nsig = Sigma;
is_real = 1;
C = fdct_usfft(f,is_real);
      for s = 2:length(C)
    for w = 1:length(C{s})
    Ssig{s}{w}= sqrt(max(((std2(C{s}{w}))^2-Nsig^2),eps));
    Thresh{s}{w} = (0.1*Nsig^2)/Ssig{s}{w};
    Ct{s}{w} = wthresh(C{s}{w},'s', Thresh{s}{w});
    end
      end
      Ct{1}{1}=C{1}{1};
y = ifdct_usfft(Ct,is_real);

