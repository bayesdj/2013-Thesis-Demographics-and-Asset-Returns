function [m,e] = gmmmcapm(b,infoz,stat,F,Re,z)
% PURPOSE:  Moment conditions for excess returns
%-------------------------------------------------------------------------
% USAGE:  [m,e] = lingmmm(b,infoz,stat,y,x,z,w)
%  b      model parameters
%  infoz   MINZ infoz structure
%  stat   MINZ status structure
%  y,x,z  Data: dependent, independent, and instruments
%  w      GMM weighting matrix
%-------------------------------------------------------------------------
% RETURNS:
%  m      vector of moment conditions
%  e      Model errors  (Nobs x Neq)
%-------------------------------------------------------------------------

[T,n] = size(Re);
p = size(F,2);
mu = b(p+1:end)';
b = b(1:p);

e = (1-F*b)*ones(1,n).*Re;
e = [e F-ones(T,1)*mu];
       
m = vec(z'*e/T);

end

