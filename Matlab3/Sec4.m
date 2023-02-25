clear;
load('Data1.mat');
data1Handle;

per = P.t0;
Y = R.rSP(per);
z = x1;
dp = D.dp(per);
X = [z dp];
cumR = cumsum(Y);
% cumX = [zeros(size(X(1,:)));cumsum(X)];
H = 1:10;
STAT = [];
rolling = 1;

for h = H(1:end)
    
    y = cumR(h+1:end)-cumR(1:end-h);
    x = X(1:end-h,:);
    % x = [x, z(h+1:end)-z(1:end-h)];
    nP = size(x,2);
    if rolling ~= 1
        yx = flipud([y,x]);
        yx = yx(1:h:end,:);
        yx = flipud(yx);
        y = yx(:,1);
        x = yx(:,2:end);
    end
    STAT = [STAT; [ones(nP,1)*h,(1:nP)',getReg(y,x)]];
    
end

STAT(:,end) = STAT(:,end)./(STAT(:,1).^0.5);  % annualize rmse
corr(x)
delete('matlabResult.xlsx');
xlswrite('matlabResult.xlsx',STAT);

