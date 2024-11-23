function Gkk = Gk(r0, N, k, sf1, sf2)
    w1_ = linspace(-pi,pi,sf1);
    w2_ = linspace(-pi,pi,sf2);
    w1 = repmat(w1_',1,sf2);
    w2 = repmat(w2_,sf1,1);
    absw = sqrt(w1.^2+w2.^2);
    Gkk = exp(1j.*absw.*r0).*Fk_final(absw,N,k);
% Gkk = exp(1j.*absw.*r0).*(Fk(absw, N, k)+Fk(absw+k*pi, N, k)+Fk(absw-k*pi, N, k));

end