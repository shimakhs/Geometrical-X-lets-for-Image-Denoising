function y = contourlet_denoise(f,Sigma,method)
% Parameters
pfilt = '9-7';
dfilt = 'pkva';
Nsig = Sigma;
nlevs = [0, 0, 4, 4, 5];    % Number of levels for DFB at each pyramidal level
y = pdfbdec(f, pfilt, dfilt, nlevs);
% [c, s] = pdfb2vec(y);
y1{1,1} = y{1,1};
for i = 2:6
 for   j = 1:size(y{1,i},2)
    Ssig{1,i}{1,j}= sqrt(max((std2(y{1,i}{1,j})^2-Nsig^2),eps));
    Thresh{1,i}{1,j} = (0.2*Nsig^2)/Ssig{1,i}{1,j};
    y1{1,i}{1,j} = wthresh(y{1,i}{1,j},'s', Thresh{1,i}{1,j});
 end
end

% Reconstruction
y = pdfbrec(y1, pfilt, dfilt);