function [ CapitalH, hk ] = getCapitalH( Incomes,WT,P )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    [T,Y] = size(Incomes);
    g = P.g;
    die = P.die;
    i = (0:die-1)';
    i = g.^i;
    lifeExp = P.lifeExp - 20;
    check = ones(T,1)*(1:die);
    check = (check <= lifeExp*ones(1,Y));
    check = [check; ones(die-1,Y)];
    hk = zeros(T,Y);
    Pop = P.Pop.*(P.employed*ones(1,Y));
    
    for t = 1:T 
        period = (t:t+die-1)';
        checkAlive = check(period,:);
        I = Incomes(t,:);
        Future = (i*I).*checkAlive;
        for j = die-1:-1:1
            for y = die-1:-1:1
                Future(j,y) = P.discount*Future(j+1,y+1)+Future(j,y);
            end
        end
        hk(t,:) = Future(1,:);
    end
    
    HK = hk.*Pop.*WT;
    CapitalH = sum(HK,2);
end

