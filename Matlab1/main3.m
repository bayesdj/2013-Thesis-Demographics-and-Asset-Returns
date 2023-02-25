clear;
close all;
load('Data.mat');

% test
% P.indexI = ones(73,1);
% P.employed = ones(73,1);
% get HumanK / K ratio ********************************************
I = P.I;
index = P.indexI;
I(P.retire:end) = P.ss; % lives only on socical security
Incomes = applyGrowth(I, index, index(end-1));  % base year is 2011
Consumes = applyGrowth(P.C, index, index(end-1));
Incomes0 = applyGrowth(P.I, index, index(end-1));

Lags = [0,1,2,3,4,5];
BeginK = [0,0.2,0.3,0.5,0.7,1,2,5,10];
Table = zeros(length(Lags)*length(BeginK),5);
Re6 = R.FF6 - R.Rf*ones(1,6);
Re4 = [R.Rf, R.Bond4];
Re0 = [Re4, Re6];
period = R.t3;
gmmopt = getGMMopt('gmmmRe','gmmjRe',12);    
[Capital,WT] = getCapital(Incomes,Consumes,P,0);
CapitalH = getCapitalH(Incomes0,WT,P);
i = 1;
for b = BeginK
    Capital = getCapital(Incomes,Consumes,P,b);
    X = CapitalH ./ Capital;
    % X = [P.indexI, P.employed];
    X = [zeros(size(X(1,:))); X(2:end,:)-X(1:end-1,:)];
    for lag = Lags
        F = X(period-lag,:);
        Re = Re6(period,:);
        b0 = regress(Re(:,1),F);        
        out6 = gmm(b0,gmmopt,F,Re,ones(size(Re(:,1))));
        Re = Re4(period,:);
        b0 = regress(Re(:,1),F);
        out4 = gmm(b0,gmmopt,F,Re,ones(size(Re(:,1))));
        Re = Re0(period,:);
        b0 = regress(Re(:,1),F);
        out0 = gmm(b0,gmmopt,F,Re,ones(size(Re(:,1))));
        Table(i,:) = [b,lag,out6.p,out4.p,out0.p];
        i = i+1;
    end
end

xlswrite('Test1.xlsx',Table);
