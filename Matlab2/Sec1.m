clear;
load('data1.mat');
close all;

D.Names = {'s4064','s65','s4064/20','s65/20','avg20','median','s2064','my',...
    'dependOld','depend','X11','X12'}; 
class = 'D.';
nName = length(D.Names);

per = P.t0;
for i = 1:nName
    name = D.Names{i};
    x = eval(strcat(class,name));
    figure;
    [ax,h1,h2] = plotyy(D.Year,x,D.Year(per),-D.dp);
    xlabel('Year');
    % title(name,'FontSize',12);    
    legend(name,'log(P/D)');
    g = line([2013 2013],[min(x) max(x)]);
    set(g,'linestyle','--', 'color', 'black');
end

per = 41:113;
per = 54:113;
figure;
name = 'D.cay';
x = eval(name);
plotyy(D.Year(per),-D.dp(per), D.Year(per),x);
xlabel('Year');
title(name,'FontSize',12);
g = line([2013 2013],[min(x) max(x)]);
set(g,'linestyle','--', 'color', 'black');