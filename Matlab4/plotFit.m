function plotFit( time, y, yhat, scen, h, m )
    if nargin <= 5
        m = 0;
    end
    switch scen
        case 1  % SP500
            titleName = 'r = SP500; ';
        case 2  % FF3 Rm
            titleName = 'r = Rm; ';
        case 3  % FamaBliss Bond
            titleName = 'r = Treasury; ';
        case 4  % rHouse
            titleName = 'r = Housing; ';
    end
    t = time;
    seeFuture = 0;
    
    figure; 
    plot(t,y, 'Color', [0,0,h/10]); hold on;
    if length(yhat) > length(y)
        t = time(1):2060;
        seeFuture = 1;
    end
    plot(t,yhat,'Color',[1,0,0]);
    xlabel('Year');
    ylabel('Logged Return');
    
    titleName = [titleName, 'h = ',num2str(h)];
    if m > 0
        titleName = [titleName, '; m = ', num2str(m)];
    end
    title(titleName,'Fontsize',12);
    legend('actual', 'fitted', 'Location', 'Best');
    if seeFuture == 1
        g = line([2012 2012],[min(y) max(y)]);
        set(g,'linestyle','--', 'color', 'black');
    end
    g = refline(0,0);
    set(g,'color', [0.8,0.8,0.8]); 
    hold off;
end