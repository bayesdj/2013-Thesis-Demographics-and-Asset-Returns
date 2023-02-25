%clear;
load('Data1.mat');
close all;
per = (48:113)';
per = (54:113)';
per = P.t0;
Y = R.rSP(per);
my = D.my(per);
dp = D.dp(per);
X = [my, dp];
cumR = cumsum(Y);
cumMY = cumsum(my);
H = 1:10;
nH = length(H);
h = H(1);
y = cumR(h+1:end)-cumR(1:end-h);
x = X(1:end-h,:);
x = [x, cumMY(h+1:end)-cumMY(1:end-h)];
nP = size(x,2);
STAT = [ones(nP,1)*h, (1:nP)', getReg(y,x)];
STAT = repmat(STAT,nH,1);

% i = nP+1;
% for h = H(2:end);
%     y = cumR(h+1:end)-cumR(1:end-h);
%     x = X(1:end-h,:);
%     x = [x, cumMY(h+1:end)-cumMY(1:end-h)];
%     STAT(i:i+nP-1,:) = [ones(nP,1)*h,(1:nP)',getReg(y,x)];
%     i = i+nP;
% end
% 
% STAT(:,end) = STAT(:,end)./(STAT(:,1).^0.5);  % annualize rmse

n = size(x,1);
x = [ones(n,1),x];
b = regress(y,x);
yhat = x*b;
years = (1900:1900+n-1);
plot(years,[yhat, y, yhat1]);
legend('fit: MY+dp','actual','fit: MY only');
title('1 Year S&P Return','FontSize',12);

% delete('matlabResult.xlsx');
% xlswrite('matlabResult.xlsx',STAT);

