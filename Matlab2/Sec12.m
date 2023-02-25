clear;
close all;
load('Data1.mat');

P.indexI = ones(161,1);
P.employed = ones(161,1);
P.I = P.I(1:P.die);
P.C = P.C(1:P.die);
P.Pop = D.Pop75;
k0 = 1;
% get HumanK / K ratio ********************************************
I = P.I;
index = P.indexI;
I(P.retire:end) = P.ss; % lives only on socical security
Incomes = applyGrowth(I, index, index(end-1));  % base year is 2011
Consumes = applyGrowth(P.C, index, index(end-1));
[Capital,WT] = getCapital(Incomes,Consumes,P,k0);
Incomes = applyGrowth(P.I, index, index(end-1));
[CapitalH, hk] = getCapitalH(Incomes,WT,P);
X = CapitalH./Capital;

plotyy(P.Time,D.X11,P.Time,D.X12);
grid on;
legend('1','2');




