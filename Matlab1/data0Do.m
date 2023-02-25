% clear;
% load('Data0.mat');
% Process lifeexp *********************************************************
% Y = min(y):2012;
% T = length(Y);
% n = 10;
% LifeFit = zeros(n,T);
% 
% for i = 1:n
%     p = polyfit(y,life,i);
%     LifeFit(i,:) = polyval(p,Y);
% end
% 
% view = [Y; LifeFit];
% use = round(LifeFit(5,:));
% use(end) = 79;
% use(21:72) = round(worldbank);
% % view1 = [use(21:72); round(worldbank)]';
% lifeexp = use' + 84-79;  
% keep lifeexp;
% 
% clear;
% load('data.mat')
% 
% m = mean(P.indexI);
% m2 = P.indexI / m;
% P.indexI = m2;

% cay data ***************************************************************
cay = z(4:4:end);
cay = [cay(2:end); z(end)];




