function Wage = getWage(P,i,wEnd)

    wage = P.WageMean;
    n = size(wage,2);
    wage = wage ./ (wage(:,i)*ones(1,n));      
    
    if nargin == 3
		t2 = 161-113;
		if wEnd >= 0
			wage = mean(wage);
			W1 = ones(112,1)*wage;
			W2 = ones(t2+1,1)*wage;
			w0 = wage(end);
			w = linspace(w0,wEnd,t2+1)';
			W2(:,end) = w;
			Wage = [W1; W2];
		else
			W0 = ones(74,1)*wage(1,:);
			W1 = wage;
			W2 = ones(t2,1)*wage(end,:);
			Wage = [W0; W1; W2];
		end
    else
        Wage = mean(wage)';
    end
    
    
end



