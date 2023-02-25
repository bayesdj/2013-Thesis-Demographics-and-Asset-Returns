clear;
close all;
load('Data.mat');

indexI = P.indexI;
P.indexI = ones(73,1);
employed = P.employed;
P.employed = ones(73,1);
% get HumanK / K ratio ********************************************
I = P.I;
index = P.indexI;
I(P.retire:end) = P.ss; % lives only on socical security
Incomes = applyGrowth(I, index, index(end-1));  % base year is 2011
Consumes = applyGrowth(P.C, index, index(end-1));
[Capital,WT] = getCapital(Incomes,Consumes,P,2);
Incomes = applyGrowth(P.I, index, index(end-1));
% WT = ones(size(WT));
[CapitalH, hk] = getCapitalH(Incomes,WT,P);
X = CapitalH./Capital;
% X = P.employed;
% X = [zeros(size(X(1,:))); X(2:end,:)-X(1:end-1,:)];

% Plots ***********************************************************
% plot(P.Time,X);
% sel = [1,15,30,45,60,79]';
% plot(P.Age,hk(sel,:));
plotyy(P.Time,D.my,P.Time,D.X12);
grid on;
legend('1','2');

% GMM Estimation **************************************************
Re6 = R.FF6 - R.Rf*ones(1,6);
Re4 = R.Bond4;
Re0 = [Re4, Re6];
Rm = R.Rm;
period = getPeriod(3);
Re = Re0(period,:);
lag = 1;
period = period-lag;
F = X(period,:)-X(period-1,:);
b0 = regress(Re(:,1),F);
gmmopt = getGMMopt('gmmmRe','gmmjRe',13);
out = gmm(b0,gmmopt,F,Re,ones(size(Re(:,1))));





