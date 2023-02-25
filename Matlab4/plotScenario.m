clear;
close all;
load('Data3.mat');

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
p6All = sum(D.pGroup6,2);
Wage1 = getWage(P,2,1);
Wage2 = getWage(P,2,0.5);
Sa = sum(D.pGroup6.*Wage1,2) ./ p6All;
Sb = sum(D.pGroup6.*Wage2,2) ./ p6All;
[~,S2,~,~,~] = getSeries(2,2,R,V,P,D);
my = D.my;
x = S2;
h = plot(P.Time,[Sa Sb x]); 
set(h(3),'color',[0 0 0]);
legend('w=1','w=0.5','w=0.72','Location','Best'); 
title('S2 with Different Wage at 2060','fontsize',12);
g = line([2012 2012],[min(x) max(x)]);
set(g,'linestyle','--', 'color', 'black');

h = 10;
beg = 1; % 28,53
DS = S2(beg+h:end)-S2(beg:end-h);
DSa = Sa(beg+h:end)-Sa(beg:end-h);
DSb = Sb(beg+h:end)-Sb(beg:end-h);
time = P.Time(beg+h:end);
S = S2(beg:end-h);
Sa = Sa(beg:end-h);
Sb = Sb(beg:end-h);
one = ones(size(S));
b = P.bS2;
% b = P.bBond5;
b = P.bHouse10;
yhat = [one S DS]*b;
yhata = [one Sa DSa]*b;
yhatb = [one Sb DSb]*b;
y = R.rm10;
% y = R.rBond5;
y = R.rHouse10;
figure;
gr = plot(time,[yhata,yhatb,yhat]); hold on;
set(gr(3),'color',[0 0 0]);
time = P.Time(beg+h:113);
gr = plot(time,y); hold off;
set(gr(1),'color',0.5*[1 1 1]);
legend('w=1','w=0.5','w=0.72','r (h=10)','Location','Best'); 
title('Fitted Return for Housing with Diff Wage at 2060','fontsize',12);
g = line([2012 2012],[min(y) max(y)]);
set(g,'linestyle','--', 'color', 'black');
g = refline(0,0);
set(g,'color', [0.8,0.8,0.8]); 

