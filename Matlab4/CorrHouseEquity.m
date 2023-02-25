clear;
close all;
load('Data2.mat');
% use current population est of MY(t+h).

B = cumsum(R.rFF3(:,1),1);
A = cumsum(R.rHouse);
Rho = zeros(1,10);

for h = 1:10

    a = A(h+1:end)-A(1:end-h);
    b = B(h+1:end)-B(1:end-h);
    sizeA = size(a,1);
    sizeB = size(b,1);

    if sizeA >= sizeB
        a = a(end-sizeB+1:end,:);
    else
        b = b(end-sizeA+1:end,:);
    end
    Rho(h) = corr(a,b);
    
end

Rho
