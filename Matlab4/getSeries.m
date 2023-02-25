function [Y,S,v,per,myDif] = getSeries(scen,var,R,V,P,D)
    switch scen
        case 1  % SP500
            per = 1:52;
            Y = R.rSP(per);
            v = V.dp(per);
        case 2  % FF3 Rm
            per = 53:113; % 28:113
            Y = [zeros(27,1);R.rFF3(:,1)];
            Y = Y(per);
            v = V.dp(per);
        case 3  % FamaBliss Bond
            Y = 0; % disregard
            per = 53:113;
            v = log(100 ./ V.PBond(:,2:end));
        case 4  % rHouse
            per = 53:113;
            Y = R.rHouse(per);
            v = 0.01*V.PHouse(per);
        case 5
            per = 16:113;
            Y = R.rHouse(per);
            v = [0.01*V.PHouse(per), log(V.rentYield)];
        case 6
            per = 1:111;
            Y = R.rHouse(per);
            v = V.longRate;
    end
    wage = getWage(P,2);
    consume = P.Consume ./ (P.Consume(:,2)*ones(1,6));
    consume = mean(consume)';
    p6All = sum(D.pGroup6,2);
%     py = sum(D.PopAll(:,21:43),2);
%     pm = sum(D.PopAll(:,44:66),2);
%     pr = sum(D.PopAll(:,67:end),2);
    pR = sum(D.PopAll(:,61:end),2);
    pM = sum(D.PopAll(:,41:60),2);
    pY = sum(D.PopAll(:,21:40),2);    
    my = D.my(per);
    MY = D.MY(per,2:end);
    myDif = MY - my*ones(size(MY(1,:)));
    switch var
        case 0  
            s = D.my;
        case 1
            s = 1-D.s6520;
        case 2 
            s = D.pGroup6*wage ./ p6All;
        case 3
            s = D.pGroup6*wage ./ (D.pGroup6*consume);
        case 4
            % s = (2*py + 3*pm) ./ (pm+py+pr)*0.5;
            s = (2*pY + 3*pM + 0*pR) ./ (pY+pM+0*pR) * 0.5;
        case 5
            s = pM./pY;
        case 6
            Wage = getWage(P,2,-1);
            s = sum(D.pGroup6.*Wage,2) ./ p6All;
        case 7
            s = D.pGroup6*mean(P.wcNorm)' ./ p6All;
        case 8
            wage = [0.6572 1 1.0726 1.1045 1.1355 1.0445]';
            s = D.pGroup6*wage ./ p6All;
        case 9
            s = 0.01*P.t0;
    end
    S = s;
    warning('Off', 'MATLAB:xlswrite:AddSheet');
    warning('Off', 'MATLAB:DELETE:FileNotFound');
    delete('matlabResult.xlsx');
end