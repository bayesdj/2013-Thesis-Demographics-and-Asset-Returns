clear;
load('Data.mat');

Xall = [D.s4064, D.s65, D.s406420, D.s6520, D.avg20, D.median, D.s2064, ...
        D.my, D.X1, D.X2, D.X3, D.X33, D.X320, D.X3200, P.employed, P.indexI];
    
Yall = [R.Rm, [R.FF6 - R.Rf*ones(1,6)], R.Rf, R.Bond4];

xSel = 12:14;
ySel = 1;
Lags = (0:3);
Per = (3:5);
statTable = zeros(size(ySel,2)*size(xSel,2)*size(Lags,2)*size(Per,2),4+8);
i = 1;
for iy = ySel
    Y = Yall(:,iy);
    for ix = xSel
        X = Xall(:,ix);
        for lag = Lags
            for per = Per
                period = getPeriod(per);
                y = Y(period);
                period = period - lag;
                x = X(period,:)-X(period-1,:);
                % x = X(period);
                statTable(i,:) = [iy ix lag per,getReg(y,x)];
                i = i+1;
            end
        end
    end
end

% xlswrite('regResults.xlsx',statTable);