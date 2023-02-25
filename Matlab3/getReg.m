function [ stats ] = getReg( Y, X, ifOrgin )
% stats = [b, tStat(ols,gmm), pValue(ols,gmm), R2, R2adj,pValue_OLS_FStat]
%   Detailed explanation goes here
    [T,p0] = size(X);
    
    if nargin < 3 || ifOrgin == 0
        X = [ones(size(Y)), X];
        p = p0+1;
    else
        p = p0;
    end
    
    [b,~,e,~,olsStat] = regress(Y,X);
    G = repmat(e,1,p).*X;
    g = mean(G);
    S = SNW(G);
    d = -(X'*X)/T;
    varB = inv(d/S*d')/T;
    % J = T*g/S*g';
    % pGMM = 1-chi2cdf(J,0);
    tStatNW = b./(diag(varB).^0.5);
    
    rmse = sqrt(olsStat(4));
    R2 = olsStat(1);
    R2adj = 1-(1-R2)*(T-1)/(T-p);    
    
    varBOLS = olsStat(4)*inv(X'*X);    
    tStatOLS = b./(diag(varBOLS).^0.5);
    tstat = [tStatOLS, tStatNW];
    pValue = 2*(1-tcdf(abs(tstat),T-p));
    
    stats = [b, tstat, pValue];
    stats = stats(end-p0+1:end,:);
    stats = [stats, ones(p0,1)*[R2,R2adj,olsStat(3),rmse]];        
end

