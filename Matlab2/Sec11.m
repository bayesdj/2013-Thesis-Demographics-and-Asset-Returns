clear;
close all;
load('Data1.mat');

% subjective discount factor, can actually vary against age, can be function of unemployment
Pop = D.Pop75;
die = P.die;
I = P.I(1:die);
C = P.C(1:die);
[T,Y] = size(Pop);
k0 = 1;

I(46:end) = P.ss; % 21+46-1 = 66, soc sec is the only income from age 66
tax = getTax(I,C,0.7);
I = I - tax;
Discount = zeros(Y,Y);
i = 0:die-1;
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
k = k + k0*k(1);   % Add capital endowment in the beginning.
X = hk./k;

plotyy(P.Time,X,P.Time,D.my);
legend('x','2');
% plotyy(Year, hk./k, Year, [x; zeros(5,1)]);
% clear T Y tax C I Pop i t Discount B ss;