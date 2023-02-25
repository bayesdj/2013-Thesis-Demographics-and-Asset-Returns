clear;
close all;
load('Data3.mat');

y = R.rSP;
y = cumsum(y);
y = y(11:end)-y(1:end-10);
time = P.Time(11:end);
gr = plot(time,P.yhat); hold on;
set(gr(1),'color',[0 0 1]);
time = P.Time(11:113);
gr = plot(time,y); hold off;
legend('fitted','actual','Location','Best'); 
title('SP500 Fitted Return from 1900-1952','fontsize',12);
g = line([2012 2012],[min(y) max(y)]);
set(g,'linestyle','--', 'color', 'black');
g = refline(0,0);
set(g,'color', [0.8,0.8,0.8]); 

% i = 2;
% c = P.Consume ./ (P.Consume(:,i)*ones(1,6));
% w = P.WageMean ./ (P.WageMean(:,i)*ones(1,6));
% w = w(end-25+1:end,:);
% wc = w./c;
% 
% c = P.Consume;
% w = P.WageMean(end-25+1:end,:);
% wc = w./c;
% wcNorm = wc ./ (wc(:,2)*ones(1,6));

% x = zeros(161,6);
% pop = D.PopAll;
% x(:,1) = sum(pop(:,17:25),2);
% x(:,2) = sum(pop(:,26:35),2);
% x(:,3) = sum(pop(:,36:45),2);
% x(:,4) = sum(pop(:,46:55),2);
% x(:,5) = sum(pop(:,56:65),2);
% x(:,6) = sum(pop(:,66:end),2);
% D.pGroup6 = x;
% 
% keep D P R V;
% save('Data3.mat');
% 
% clear;
% close all;
% load('Data3.mat')
% 
% y = V.dp;
% t = P.Time(1:113);
% 
% plot(t,y);
% title('Logged S&P500 Dividend Yield','FontSize',12);  



