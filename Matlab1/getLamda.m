function [ lamda, VLamda ] = getLamda( h,F,V )
%   Summary of this function goes here
%   Detailed explanation goes here
    
    p = size(F,2);
    hs = size(h,1);
    Y = eye(hs,p)*cov(F);
    x = [h(p+1:end)', zeros(1,hs-p)];
    
    onehx = 1-h'*x';
    lamda = h'*Y / onehx;
    
    H = onehx^-2*(Y'*onehx + Y'*h*x);
    VLamda = H*V*H';

end

