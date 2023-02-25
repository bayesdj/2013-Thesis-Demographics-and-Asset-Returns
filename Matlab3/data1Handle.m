% clear;
% close all;
% load('data1.mat');
% per = 1:161;
% 
% Y = P.P2039;
% X = [ones(size(Y)), P.Time];
% 
% yHat = X*regress(Y,X);
% y = Y-yHat;
% 
% plot(P.Time,y);
% ylabel('millions');
% title('Figure 2-1: Detrended Population in Age 20-39','FontSize',12);
% g = line([2013 2013],[min(y) max(y)]);
% set(g,'linestyle','--', 'color', 'black');

% clear;
% load('data.mat');
% plot(P.Age,P.I);

% *************************************************************************
% per = 41:113;
% wages = [1,1.33,1.66,2,1.66,1.33]';
% % wages = P.wages; 
% y = -D.dp(per);
% pop = D.pGroup6(per,:);
% employed = P.Employed2;
% supply = D.pGroup6*wages./sum(D.pGroup6,2);
% x1 = (pop.*employed)*wages./sum(pop,2);
% x2 = P.employed;
% % x3 = 1-D.s6520;
% % plot(D.Year(per),y);
% % title('MY Ratio: 1900-2012','Fontsize',12);
% % figure;
% [ax,h1,h2] = plotyy(D.Year(per),y,D.Year(per),x1);
% xlabel('Year');
% title('X1 vs Log(P/D)','FontSize',12);    
% legend('pd', 'x1');
% g = line([2013 2013],[min(y) max(y)]);
% set(g,'linestyle','--', 'color', 'black');
% % *************************************************************************
per = 1:113;
pd = -D.dp(per);
yr = P.Time(per);
% x1 = z;
% x2 = D.my(per);
% stat1 = regstats(y,x1,'linear');
% r2 = stat1.rsquare
% t = stat1.tstat.t
% stat2 = regstats(y,x2,'linear');
% r2_2 = stat2.rsquare
% t_2 = stat2.tstat.t
% stat3 = regstats(y,x3(per),'linear');
per = 1:161;
my2 = D.my2040;
my1 = D.my;
year = P.Time(per);
plotyy(yr,pd,year,[my1 my2]);
legend('pd','MY1','MY2');
title('Figure 2-2: MY Ratio vs ln(P/D)', 'Fontsize',12);
g = line([2012 2012],[min(pd), max(pd)]);
set(g,'linestyle','--', 'color', 'black');
xlabel('Year');
% % *************************************************************************
% H = 1:10;
% time = P.Time(per);
% 
% for h = H(1:end)    
%     myd = my(h+1:end)-my(1:end-h);
%     mrd = mr(h+1:end)-mr(1:end-h);
%     figure;
%     plot(time(h+1:end),[myd,mrd]);
%     legend('X=MY','X=MR');
%     title(['X(t+', num2str(h), ')-X(t)'],'Fontsize',12);  
%     g = line([2013 2013],[min(mrd), max(mrd)]);
%     set(g,'linestyle','--', 'color', 'black');
% end
% % *************************************************************************


