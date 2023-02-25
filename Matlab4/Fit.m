clear;
close all;
load('Data3.mat');
% Graph fitted values vs actual.

scen = 3; % 1-SP500; 2-Rm; 3-M5Bond; 4-Housing
var = 0;  % 0-MY; 1-S1; 2-S2; 9-time;
dOut = 0; % leave out demographic varialbes
control = 0; % include control variable Z
base = 2; % 1-s; 2-ds; 3-[s ds];
dy = 0; % include previous return in regression
graphIdx = 0; % graphs as index level rather than return
graphOver = 0;
rolling = 0; % parameter using rollling window
H = [1,10]; % investment horizons
% H = (1:10);

begin = 1;
per = begin:113;
switch scen
    case 1  % SP500
        Y = R.rSP(per);
        Z = V.dp(per);
        yName = 'SP500';
        zName = 'dp';
    case 2  % FF3 Rm
        begin = 28;
        per = begin:113;
        Y = R.rFF3(:,1);
        Z = V.dp(per);
        yName = 'Rm';
        zName = 'dp';
    case 3  % 5 yr Bond
        begin = 53;
        per = begin:113;
        H = [1,3,5];
        yName = 'M5 Bond';
        Y = [0; R.retM5(:,1)];
        Z = log(100 ./ V.PBond(:,5));
        zName = 'y';
    case 4  % rHouse
        Y = R.rHouse(per);
        Z = 0.01*V.PHouse(per);
        yName = 'Housing';
        zName = 'P';
end
cumR = cumsum(Y);
idx = exp(cumR);
n = length(per);
S1 = 1-D.s6520;
S2 = D.supply2; 
Wage = P.WageMean;
Wage = Wage ./ (Wage(:,2)*ones(1,6));
wage = mean(Wage)';
consume = P.Consume ./ (P.Consume(:,2)*ones(1,6));
consume = mean(consume)';
S3 = D.pGroup6*wage ./ (D.pGroup6*consume);
my = D.my;
switch var
    case 0
        S = my;
        if base == 1
            varName = 'MY';
        elseif base == 2
            varName = 'MYd';
        elseif base == 3
            varName = 'MY+MYd';
        end
    case 1
        S = S1;
        if base == 1
            varName = 'S1';
        elseif base == 2
            varName = 'S1d';
        elseif base == 3
            varName = 'S1+S1d';
        end
    case 2 
        S = S2;     
        if base == 1
            varName = 'S2';
        elseif base == 2
            varName = 'S2d';
        elseif base == 3
            varName = 'S2+S2d';
        end
    case 3
        S = S3;
        if base == 1
            varName = 'S3';
        elseif base == 2
            varName = 'S3d';
        elseif base == 3
            varName = 'S3+S3d';
        end
    case 9
        S = 0.01*(1:161)';
        base = 1;
        varName = 't';
end 
if dOut == 1
    if control == 1 && dy == 1
        varName = 'Z & r';
    elseif control == 1
        varName = 'Z';
    else
        varName = 'r';
    end
end
titleType = 'Ret';
if graphIdx == 1 
    titleType = 'Idx';
end
for h = H
    PER = begin+h:161;
    dS = S(begin+h:end)-S(begin:end-h);
    s = S(per);
    ds = s(h+1:end)-s(1:end-h);
    s = s(1:end-h,:);
    z = Z(1:end-h,:);
    y = cumR(h+1:end)-cumR(1:end-h);    
    if scen == 3
        y = R.retM5(1:end-h+1,h);
    end
    y1 = Y(h:end-1); 
    if base == 1
        x = [ones(n-h,1) s];
    elseif base == 2
        x = [ones(n-h,1) ds];
    elseif base == 3
        x = [ones(n-h,1) s ds];
    end
    if dOut == 1
        x = [ones(n-h,1) z];
    elseif control == 1 && dy == 1
        x = [x z y1];
    elseif control == 0 && dy == 1
        x = [x y1];
    elseif control == 1 && dy == 0
        x = [x z];
    end
    
    if rolling == 0
        yx = flipud([y,x]);
        yx = yx(1:h:end,:);
        yx = flipud(yx);
        yy = yx(:,1);
        xx = yx(:,2:end); 
    else
        yy = y;
        xx = x;
    end
    [b,~,err,~,stats] = regress(yy,xx);
    [T, p] = size(xx);
    R2 = stats(1);
    R2adj = 1-(1-R2)*(T-1)/(T-p); 
    R2adj = mat2str(R2adj,2);
    
    if base == 1
        X = [ones(size(dS)), S(begin:end-h,:)];
    elseif base == 2
        X = [ones(size(dS)), dS];
    elseif base == 3
        X = [ones(size(dS)), S(begin:end-h,:), dS];
    end
    if dOut == 1
        X = [ones(n,1) Z];
        PER = begin+h:113+h;
        model = zName;
    elseif control == 1 || dy == 1
        dS = dS(1:n);
        if base == 1
            X = [ones(n,1), S(per)];
        elseif base == 2
            X = [ones(n,1), dS];
        elseif base == 3
            X = [ones(n,1), S(per), dS];
        end    
        if control == 1 && dy == 1
            X = [X Z Y];
            model = [varName,'+',zName,'+r1'];
        elseif control == 1 && dy == 0
            X = [X Z];
            model = [varName,'+',zName];
        elseif control == 0 && dy == 1
            X = [X Y];
            model = [varName,'+r1'];
        end
        PER = begin+h:113+h;
    else
        model = varName;
    end

    yHat = X*b;    
    if graphIdx == 1 && control == 1
        y = log(idx(1+h:end));
        yHat = log(idx.*exp(yHat));
    end
    
    if graphOver == 1
        hold on;
        titleName = [yName,' ',titleType,': h = ',mat2str(H),', Model = ',model];
    else
        figure;
        titleName = [yName,' ',titleType,': h=',num2str(h),', Model = ',model,', adj R^2 = ',R2adj];
    end
    plot(P.Time(PER),yHat, 'Color', [1,0,0]); hold on;
    plot(P.Time(begin+h:113), y, 'Color', [0,0,h/10]);
    xlabel('Year');
    ylabel('Logged Return');
    if graphIdx == 1
        ylabel('Logged Index');
        set(gca,'xgrid','on');
    end    
    title(titleName,'FontSize',12);    
    legend('fitted', 'actual', 'Location', 'Best');
    g = line([2012 2012],[min(y) max(y)]);
    set(g,'linestyle','--', 'color', 'black');
    g = refline(0,0);
    set(g,'color', [0.8,0.8,0.8]);  
end

       

