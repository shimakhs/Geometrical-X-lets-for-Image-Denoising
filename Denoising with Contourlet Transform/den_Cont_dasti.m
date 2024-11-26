function y = den_Cont_dasti(x,T)
% Parameters
pfilt = '9-7';
dfilt = 'pkva';
nlevs = [0, 0, 4, 4, 5];    % Number of levels for DFB at each pyramidal level
y = pdfbdec(x, pfilt, dfilt, nlevs);
[c, s] = pdfb2vec(y);
% c = wthresh(c,'s',T);
c(1,257:348160) = wthresh(c(1,257:348160),'s',T);
% Reconstruction
y = vec2pdfb(c, s);
y = pdfbrec(y, pfilt, dfilt);
