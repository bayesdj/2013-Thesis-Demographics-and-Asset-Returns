clear;
load('Data.mat');

% use P.employed as business cycle control variable.

Xall = [D.s4064, D.s65, D.s406420, D.s6520, D.avg20, D.median, D.s2064, D.my, ...
    D.X1, D.X12, D.X2, D.X3, D.X33, D.X320, D.X3200, P.indexI.^2, P.employed.^2];

Yall = [R.Rm, (R.FF6 - R.Rf*ones(1,6)), R.Rf, R.Bond4];

n = 3;  % number of regressors
iN = (1:n)';
xSel = 1:size(Xall,2);
ySel = 1:size(Yall,2);
Lags = (0:2);
Per = (0:5);
statTable = zeros(size(ySel,2)*size(xSel,2)*size(Lags,2)*size(Per,2)*n,5+8);
i = 1;
for iy = ySel
    Y = Yall(:,iy);
    for ix = xSel
        X = [Xall(:,ix),P.employed,P.indexI];
        for per = Per
            if per <= 1
                lags = 0;
            else
                lags = Lags;
            end            
            for lag = lags
                period = getPeriod(per);
                y = Y(period);
                period = period - lag;
                x = X(period,:)-X(period-1,:);
                temp = [ones(n,1)*[iy ix lag per],iN];
                statTable(i:i+n-1,:) = [temp,getReg(y,x)];
                i = i+n;
            end
        end
    end
end

delete 'matlabResults.xlsx';
xlswrite('matlabResults.xlsx',statTable);