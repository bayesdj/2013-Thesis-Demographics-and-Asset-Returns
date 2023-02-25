function M = gmmjcapm(b,infoz,stat,F,Re,z)
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

[T,p] = size(F);
M = blkdiag(-F'*Re/T,-1*eye(p));
M = M';