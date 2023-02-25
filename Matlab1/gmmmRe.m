function [m,e] = gmmmRe(b,infoz,stat,F,Re,z)
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
e = (1-F*b)*ones(1,n).*Re;       
m = vec(z'*e/T);

