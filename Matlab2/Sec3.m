clear;
load('Data1.mat');
% per = (48:113)';
% per = (54:113)';
per = P.t0;
Y = R.rSP(per);
my = D.my(per);
dp = D.dp(per);
X = [dp my];
cumR = cumsum(Y);
cumMY = cumsum(my);
cumX = [zeros(size(X(1,:)));cumsum(X)];
H = 1:10;
nH = length(H);
h = H(1);
y = Y(h+1:end);
x = cumX(h+1:end-1,:)-cumX(1:end-1-h,:);
nP = size(x,2);
STAT = [ones(nP,1)*h, (1:nP)', getReg(y,x)];
STAT = repmat(STAT,nH,1);

i = nP+1;
for h = H(2:end);
    y = Y(h+1:end);
    x = cumX(h+1:end-1,:)-cumX(1:end-1-h,:);
    STAT(i:i+nP-1,:) = [ones(nP,1)*h,(1:nP)',getReg(y,x)];
    i = i+nP;
end

delete('matlabResult.xlsx');
xlswrite('matlabResult.xlsx',STAT);

