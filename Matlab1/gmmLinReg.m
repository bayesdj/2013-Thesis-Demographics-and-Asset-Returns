Y = Re(:,1);
X = [ones(size(Y)), FF3];

    [b,~,e,~,olsStat] = regress(Y,X);
    G = repmat(e,1,p).*X;
    g = mean(G);
    S = SNW(G);
    d = -(X'*X)/T;
    varB = inv(d/S*d')/T;
    J = T*g/S*g';
    pGMM = chi2cdf(J,0);
    tStatNW = b./(diag(varB).^0.5);
    
    R2 = olsStat(1);
    R2adj = 1-(1-R2)*(T-1)/(T-p);    
    
    varBOLS = olsStat(4)*inv(X'*X);    
    tStatOLS = b./(diag(varBOLS).^0.5);
    tstat = [tStatOLS, tStatNW]';
    pValue = 2*(1-tcdf(abs(tstat),T-p));
    
    stats = [b'; tstat; pValue];
    stats = [stats, [R2;R2adj;olsStat(2:3)';pGMM]];

