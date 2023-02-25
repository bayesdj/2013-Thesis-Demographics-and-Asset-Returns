clear;
close all;
load('Data2.mat');
% use current population est of MY(t+h).

i = 1;
b = R.ret1;
a = cumsum(R.rHouse(:,1),1);
a = a(i+1:end)-a(1:end-i);

sizeA = size(a,1);
sizeB = size(b,1);

if sizeA >= sizeB
    a = a(end-sizeB+1:end,:);
else
    b = b(end-sizeA+1:end,:);
end

i
rho = corr(a,b)
