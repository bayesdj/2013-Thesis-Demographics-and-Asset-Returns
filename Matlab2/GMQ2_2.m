clear;
close all;

a = 4;
d = 0.5;
N = 79;
n = 52;
D = 0.19*(2*n+3*N+2*N+3*n)/2;

minQ = 0.001;
maxQ = 0.5;
nQ = 1000;
Q1 = linspace(minQ,maxQ,nQ);
Q2 = linspace(0.5,2,nQ);
Eq1 = ones(nQ,nQ);
Eq2 = Eq1;
i = 1;
for q1 = Q1
    j = 1;
    for q2 = Q2
        c1y = (2+3*q1)/(1+q1^(1-1/a)*d^(1/a)+(q1*q2)^(1-1/a)*d^(2/a));
        c1m = c1y*(d/q1)^(1/a);
        c1r = c1y*(d^2/(q1*q2))^(1/a);

        c2y = (2+3*q2)/(1+q2^(1-1/a)*d^(1/a)+(q1*q2)^(1-1/a)*d^(2/a));
        c2m = c2y*(d/q2)^(1/a);
        c2r = c2y*(d^2/(q1*q2))^(1/a);
        
        Eq1(i,j) = N*c1y + n*c2m + N*c1r - (2*N+3*n+D);
        Eq2(i,j) = n*c2y + N*c1m + n*c2r - (2*n+3*N+D);
        j = j+1;
    end
    i = i+1;
end

Dif = abs(Eq1)+abs(Eq2);
minPossible = min(min(Dif))

mesh(Q1,Q2,Dif);
xlabel('Q1');
ylabel('Q2');
zlabel('Dif');






