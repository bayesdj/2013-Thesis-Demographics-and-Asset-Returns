clear;
syms q1 q2;
syms c1y c1m c1r c2y c2m c2r;
syms a d n N D positive;

za = 4;
zd = 0.5;
zn = 52;
zN = 79;
zD = 0.19*(2*zn+3*zN+2*zN+3*zn)/2;

c1y = (2+3*q1)/(1+q1^(1-1/a)*d^(1/a)+(q1*q2)^(1-1/a)*d^(2/a));
c1m = c1y*(d/q1)^(1/a);
c1r = c1y*(d^2/(q1*q2))^(1/a);

c2y = (2+3*q2)/(1+q2^(1-1/a)*d^(1/a)+(q1*q2)^(1-1/a)*d^(2/a));
c2m = c2y*(d/q2)^(1/a);
c2r = c2y*(d^2/(q1*q2))^(1/a);

Equ = [N*c1y + n*c2m + N*c1r - (2*N+3*n+D)];
Equ = [Equ; n*c2y + N*c1m + n*c2r - (2*n+3*N+D)];


Equ1 = subs(Equ,[a, d, n, N, D], [za, zd, zn, zN, zD]);
% Equ1 = simplify(Equ1);
qq = solve(Equ1);
% C = [[c1y, c1m, c1r]; [c2y, c2m, c2r]];
% C = subs(C, [a, d, q1, q2], [za, zd, qq.q1, qq.q2]);
% C = eval(C);
% 
% check = ones(4,1);
% check(1) = eval( C(1,:)*[1,qq.q1,qq.q1*qq.q2]'-(2+3*qq.q1) );
% check(2) = eval( C(2,:)*[1,qq.q2,qq.q1*qq.q2]'-(2+3*qq.q2) );
% check(3) = [zN,zn,zN]*[C(1,1),C(2,2),C(1,3)]'-(2*zN+3*zn+zD);
% check(4) = [zn,zN,zn]*[C(2,1),C(1,2),C(2,3)]'-(2*zn+3*zN+zD);

% bust = [zn,zN,zn]*[2.4,2,2.3]'-(2*zn+3*zN+zD);


