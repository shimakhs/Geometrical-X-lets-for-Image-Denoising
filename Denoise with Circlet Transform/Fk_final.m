function F = Fk_final(w, N, k)

    [r, c] = size(w);
    w = w(:);
    F = zeros(length(w),1);
    %%%%%
if k ==1
    for ii = 0:1

    d_p1 = abs(w+pi*ii);
    d_n1 = abs(w-pi*ii);
    
        for dp = d_p1  <= (pi/(N)) 
            F(dp) = cos(w(dp)*N/2);
        end 
        for  dp = abs(w) >pi
            F(dp)=0;
        end
                for dn = d_n1  <= (pi/(N))
            F(dn) = cos(w(dn)*N/2);
                end
                for dn = abs(w) >pi
                    F(dn)=0;
                end
    end

else
    Wk = pi*(k-1)/(N);
    d_n = abs(w-Wk);
    d_p = abs(w+Wk);
    F = zeros(length(w),1);
    dp = d_p <= (pi/(N));
    dn = d_n <= (pi/(N));
    F(dn) = cos((w(dn)-Wk)*N/2);
    F(dp) = cos((w(dp)+Wk)*N/2);
end
    F = reshape(F,r,c);

end

