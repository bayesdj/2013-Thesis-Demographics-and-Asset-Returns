clear;
close all;
load('Data3.mat');
% use current population est of MY(t+h).

scen = 4; % 1-SP500; 2-Rm; 3-FamaBliss; 4-rHouse
var = 2;  % 0-MY; 1-S1; 2-S2; 3-S/C; 4-2Y3M; 5-MY;
toGraph = 0;
toReport = 2;
H = [1:10];
noAhead = 1;

nH = length(H);
[Y,SS,v,per,myDif] = getSeries(scen,var,R,V,P,D);
cumR = cumsum(Y);
S0 = SS(per);
S1 = SS(per(1):end);
t0 = P.Time(per);
if toGraph == 1
    plotyy(P.Time,D.my,P.Time,SS); legend('my','S'); 
    title('MY vs S','fontsize',12);
end
for rolling = [1 0]
    STAT = [];
    rho = [];
    for h = H(1:end)    
        y = cumR(h+1:end)-cumR(1:end-h);
        dz = v(h+1:end)-v(1:end-h);
        dy1 = Y(h:end-1);
        s = S0(1:end-h);        
        z = v(1:end-h,:);
        t = t0(1+h:end);
        if var == 0 && noAhead == 1
            ds = myDif(1:end-h,h);
        else
            ds = S0(h+1:end)-S0(1:end-h);
        end
        % choose the model ************************************************
        y = y;
        x = [s ds];
        % ***************************************************************** 
        if rolling == 0
            tyx = [t,y,x];
            yx = flipud(tyx);
            yx = yx(1:h:end,:);
            yx = flipud(yx);
            t = yx(:,1);
            y = yx(:,2);
            x = yx(:,3:end);
        end    
        [stat, b] = getReg(y,x);
        if toGraph == 1
            S = S1(1:end-h);
            DS = S1(h+1:end)-S1(1:end-h);
            if rolling == 1
                X = [S DS]; % choose model
            else
                X = x;
            end
            yhat = [ones(size(X(:,1))) X]*b;
            plotFit(t,y,yhat,scen,h);
        end
        nP = size(x,2); 
        rho = [rho, corr(y,x)'];
        STAT = [STAT; [ones(nP,1)*h,(1:nP)',stat]];  
    end
    STAT(:,end) = STAT(:,end)./(STAT(:,1).^0.5);  % annualize rmse
    [ colHead, Report ] = getReport( STAT, nP, nH );
    nRoll = num2str(rolling);
    if toReport == 1
        xlswrite('matlabResult.xlsx',rho,['rho',nRoll]);
        % xlswrite('matlabResult.xlsx',STAT,['roll',nRoll]);    
        xlswrite('matlabResult.xlsx',colHead,['report',nRoll]);
        xlswrite('matlabResult.xlsx',Report,['report',nRoll],'A2');
    elseif toReport == 2
        disptable([scen var rolling], {'scen','var','rolling'})
        disptable(Report,colHead)
        rho
    end
end
% clear temp MY Wage cumR Y myDif x1 x2 yx nRoll STAT rho;
if toReport == 1, winopen('matlabResult.xlsx'), end;
