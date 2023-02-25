function [ colHead, Report ] = getReport( STAT, nP, nH, ifBond )

    if nargin <= 3 || ifBond == 0
        colHead = {'h'};
        sortRow = [2 1];
        temp = sortrows(STAT,sortRow);
        Report = ones(2*nH,3*nP+5);
        Report(:,1) = repmat(temp(1:nH,1),2,1);
        Report(1:nH,end-4+1:end) = temp(1:nH,end-4+1:end);
        for i = 0:nP-1
            Report(1:nH,(2:4)+3*i) = temp((1:nH)+i*nH,(3:5));
            Report(nH+(1:nH),(3:4)+3*i) = temp((1:nH)+i*nH,(6:7));
            colHead = [colHead,['B',num2str(i+1)],'t1','t2'];
        end
    else
        colHead = {'m','h'};
        sortRow = [3 1 2];
        temp = sortrows(STAT,sortRow);
        Report = ones(nH*2,3*nP+6);
        Report(:,1:2) = repmat(temp(1:nH,(1:2)),2,1);
        Report(1:nH,end-4+1:end) = temp(1:nH,end-4+1:end);
        for i = 0:nP-1
            Report(1:nH,(3:5)+3*i) = temp((1:nH)+i*nH,(4:6));
            Report(nH+(1:nH),(4:5)+3*i) = temp((1:nH)+i*nH,(7:8));
            colHead = [colHead,['B',num2str(i+1)],'t1','t2'];
        end
    end
    
    colHead = [colHead,'R2','R2 adj','p>F','rmse'];

end