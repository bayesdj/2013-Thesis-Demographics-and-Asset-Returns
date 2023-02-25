clear;
close all;
load('Data1.mat');
% use current population est of MY(t+h).

per = P.t0;
Y = R.rSP(per);
dp = D.dp(per);
MY = D.MY(per,2:end);
my = D.my(per);
myDif = MY - my*ones(size(MY(1,:)));
cumR = cumsum(Y);
STAT = [];
H = 1:10;

for h = 1:10    
    y = my(1+h:end);
    x = MY(1:end-h,h);
%     yx = flipud([y,x]);
%     yx = yx(1:h:end,:);
%     yx = flipud(yx);
%     y = yx(:,1);
%     x = yx(:,2:end);
    STAT = [STAT; [h, getReg(y,x)]];  
    figure;
    plot(1900+h+(1:length(y)),[y,x]);
    legend('y','x');
end

% rollingWindow = 1;
% X = [my, dp];
% for h = H(1:end)    
%     y = cumR(h+1:end)-cumR(1:end-h);
%     x = X(1:end-h,:); 
%     da = my(h+1:end)-my(1:end-h);
%     db = myDif(1:end-h,h);
%     dc = da - db;
%     x = [da];
%     nP = size(x,2);
%     if rollingWindow ~= 1
%         yx = flipud([y,x]);
%         yx = yx(1:h:end,:);
%         yx = flipud(yx);
%         y = yx(:,1);
%         x = yx(:,2:end);
%     end
%     STAT = [STAT; [ones(nP,1)*h,(1:nP)',getReg(y,x)]];
%     figure;
%     plot(P.Time(h+1:113),x(:,end));
%     title(['MY(t+', num2str(h), ')-MY(t)'],'Fontsize',12);    
% end
% STAT(:,end) = STAT(:,end)./(STAT(:,1).^0.5);  % annualize rmse
% % 
% delete('matlabResult.xlsx');
% xlswrite('matlabResult.xlsx',STAT);
% corrX = corr(x)
