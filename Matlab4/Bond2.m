clear;
close all;
load('Data3.mat');
% use current population est of MY(t+h).

var = 2; % Scenarios are 0) my, 1) S1, 2) S2
toGraph = 1;       
rolling = 1;
toReport = 2;
noAhead = 0;

[~,SS,yield,per,myDif] = getSeries(3,var,R,V,P,D);
rho = zeros(15,5);
STAT = [];
S0 = SS(per);
S1 = SS(per(1):end);
t0 = P.Time(per);

for h = (1:5)
    switch h
        case 1
            Y = R.ret1;
        case 2
            Y = R.ret2;
        case 3
            Y = R.ret3;
        case 4
            Y = R.ret4;
        case 5
            Y = R.ret5;
    end        
    if var == 0 && noAhead == 1
        ds = myDif(1:end-h,h);   
    else
        ds = S0(h+1:end)-S0(1:end-h);  
    end
    s = S0(1:end-h,:); 
    v = yield(1:end-h,:); % yield as control var   
    dv = yield(h+1:end,:)-yield(1:end-h,:);
    
    Mat = h:5;    
    i = 1;    
    for m = Mat(1:end)    
        y = Y(:,i);        
        z = v(:,m);
        dz = dv(:,m);
        t = t0(1+h:end);
        % Model ************************************************
        y = y;
        x = [s ds];  
        % ******************************************************
        if rolling == 0
            all = [t,y,x];
            yx = flipud(all);
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
                X = [DS];
            end
            yhat = [ones(size(X(:,1))) X]*b;
            plotFit(t,y,yhat,3,h,m);
        end
        nP = size(x,2);
        rho((1:nP)+nP*(m-1),h) = corr(y,x)';
        STAT = [STAT; [ones(nP,1)*[m,h],(1:nP)',getReg(y,x)]];
        STAT(end,end) = STAT(end,end)/sqrt(h); % annualize rmse
        i = i+1;
    end
end
[colHead, Report] = getReport( STAT, nP, 15, 1 );
nRoll = num2str(rolling);
if toReport == 1
    xlswrite('matlabResult.xlsx',rho,['rho',nRoll]);
    % xlswrite('matlabResult.xlsx',temp,['roll',nRoll]);    
    xlswrite('matlabResult.xlsx',colHead,['report',nRoll]);
    xlswrite('matlabResult.xlsx',Report,['report',nRoll],'A2');
    winopen('matlabResult.xlsx');
elseif toReport == 2
    disptable([var rolling],{'var','rolling'})
    disptable(Report,colHead)
end
