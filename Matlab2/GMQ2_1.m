clear;
syms q1 q2;
syms c1y c1m c1r c2y c2m c2r positive;
syms a d N n D positive;

% a = 1/4;
% d = 0.5;
% N = 79;
% n = 52;
% D = 0.19*(2*n+3*N+2*N+3*n)/2;

c1y = (2+3*q1)/(1+q1^(1-a)*d^a+(q1*q2)^(1-a)*d^(2*a));
c1m = c1y*(d/q1)^a;
c1r = c1y*(d^2/(q1*q2))^a;

c2y = (2+3*q2)/(1+q2^(1-a)*d^a+(q1*q2)^(1-a)*d^(2*a));
c2m = c2y*(d/q2)^a;
c2r = c2y*(d^2/(q1*q2))^a;

Equ = [(N*c1y + n*c2m + N*c1r - (2*N+3*n+D));...
       (n*c2y + N*c1m + n*c2r - (2*n+3*N+D))];

Equ = simplify(Equ);

% Equ1 = subs(Equ,[a, d, n, N, D], [za, zd, zn, zN, zD]);
% Equ1 = simplify(Equ1);
qq = solve(Equ,[q1,q2]);
% C = [[c1y, c1m, c1r]; [c2y, c2m, c2r]];
% C = subs(C, [q1, q2], [qq.q1, qq.q2]);
% C = eval(C);
% 
% check = ones(4,1);
% check(1) = eval( C(1,:)*[1,qq.q1,qq.q1*qq.q2]'-(2+3*qq.q1) );
% check(2) = eval( C(2,:)*[1,qq.q2,qq.q1*qq.q2]'-(2+3*qq.q2) );
% check(3) = [N,n,N]*[C(1,1),C(2,2),C(1,3)]'-(2*N+3*n+D);
% check(4) = [n,N,n]*[C(2,1),C(1,2),C(2,3)]'-(2*n+3*N+D);
% 
% bust = [n,N,n]*[2.4,2,2.3]'-(2*n+3*N+D);


