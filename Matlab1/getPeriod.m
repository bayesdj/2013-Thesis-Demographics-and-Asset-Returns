function [ period ] = getPeriod(id,time0,time1)
%UNTITLED Summary of this function goes here
%   get time period
    tEnd = 73;
%     t2 = 2;
%     t2H = t2+round((tEnd-t2+1)/2)-1;
%     t14 = 14;
%     t14H = t14+round((tEnd-t14+1)/2)-1;
        
    if nargin == 1
        switch id
            case 0
                period = (2:tEnd);
            case 1
                period = (2:37);
            case 2
                period = (38:tEnd);
            case 3
                period = (14:tEnd);
            case 4
                period = (14:43);
            case 5
                period = (44:tEnd);
        end
    elseif nargin == 2
        period = (time0:tEnd);
    else
        period = (time0:time1);
    end
    
    period = period';

end

