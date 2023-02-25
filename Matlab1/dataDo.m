% clear;
% load('Data1.mat');
% P.B = 1/1.057;   % avg natural rate of unemployment after WW2
% P.ss = 1230*12;   % avg social security payment
% P.ub = 300*26;    % unemployment benefit
% P.g = 1.02;     % long-term growth rate
% P.retire = 46; % 21+46-1 = 66, retire at age 66
% P.die = 64; % die at age 84
% save('Data1.mat');

% curve fitting for Income and Consumption ********************************
    % Age = (21:85);
    % p = polyfit(Age,Income,16);
    % IFit = polyval(p,Age);
    % plot(Age,[Income; IFit]);
    % plot(Age,IFit);
    % 
    % p = polyfit(Age,Consume,11);
    % CFit = polyval(p,Age);
    % plot(Age,[Consume; CFit]);
    % plot(Age,CFit);
    % 
    % clear p;

% age distribution into matrix ********************************************
    T = 2060-1900+1;
    Y = 75-21+1;
    
    x = zeros(T,Y);
    Pop = Pop';
    
    for t = 1:T
        x(t,:) = Pop((1:Y)+(t-1)*Y);
    end
    

    


