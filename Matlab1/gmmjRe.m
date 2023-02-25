function M = gmmjRe(b,infoz,stat,F,Re,z)
% PURPOSE:  Provide derivative of moment conditions (Jacobian) for
%             linear GMM estimation
%-------------------------------------------------------------------------
% USAGE:  M = lingmmj(b,infoz,stat,y,x,z)
%  b      k-vector of model parameters
%  infoz   MINZ infoz structure
%  stat   MINZ status structure
%  y,x,z  Data: dependent, independent, and instruments
%-------------------------------------------------------------------------
% RETURNS:
%  M      Jacobian  (rows(m) x k)
%-------------------------------------------------------------------------

T = size(F,1);
M = -F'*Re/T;
M = M';