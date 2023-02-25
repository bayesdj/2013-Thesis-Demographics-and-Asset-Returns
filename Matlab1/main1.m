clear;
close all;
load('Data.mat');

% subjective discount factor, can actually vary against age, can be function of unemployment
Pop = P.Pop;
I = P.I;
C = P.C;
[T,Y] = size(Pop);

I(46:end) = P.ss; % 21+46-1 = 66, soc sec is the only income from age 66
tax = getTax(I,C,0.5);
I = I - tax;
Discount = zeros(Y,Y);
i = 0:P.die-1;
i = P.discount .^ i';

for y = 1:Y
    Discount(y:end,y) = i(1:end-y+1);
end

K = I - C;
K = cumsum(K);
KHuman = I*Discount;

k = K.*(K>0);
k = (ones(T,1)*k).*Pop;
WT = k ./ (sum(k,2)*ones(1,Y));
hk = (ones(T,1)*KHuman).*Pop.*WT;
hk = sum(hk,2);
k = sum(k,2);
k = k + 0.5*k(1);   % Add capital endowment in the beginning.
X = hk./k;

plotyy(P.Time,X,P.Time,D.my);
% plotyy(Year, hk./k, Year, [x; zeros(5,1)]);
% clear T Y tax C I Pop i t Discount B ss;