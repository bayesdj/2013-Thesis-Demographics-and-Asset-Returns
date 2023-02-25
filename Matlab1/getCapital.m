function [ Capital, Weight,k ] = getCapital( Incomes,Consumes,P,beginK )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
    if nargin < 4, beginK = 1; end;
    g = P.g;
    retire = P.retire;    
    [T,Y] = size(P.Pop);
    k = zeros(T,Y); 
    Pop = P.Pop.*(P.employed*ones(1,Y));
   
    for t = 1:T
        I = Incomes(t,:);
        C = Consumes(t,:);
        tax = getTax(I,C,0.5);
        k(t,:) = I-tax-C;
    end
    i = (retire-1:-1:1)';
    i = (1/g).^i;
    k0 = i*k(1,:);
    k = [k0;k];
    T1 = size(k,1);
    
    for t = 2:T1
        for y = 2:Y
            k(t,y) = k(t-1,y-1)+k(t,y);
        end
    end
    k = k(retire:end,:);
    K = k.*Pop;
    Capital = sum(K,2);
    Weight = K ./ ( Capital*ones(1,Y) );
    Capital = Capital(1)*beginK + Capital;

end

