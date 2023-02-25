clear;
load('Data2.mat');

gmmopt.gmmit = 11;
gmmopt.S = 'NW';
gmmopt.W0 = 'I';

% testing stocks
% T = size(FF6,1);
% z = ones(T,1);
% Re = FF25 - Rf*ones(1,size(FF25,2));
% F = X;

% testing bonds
Bond4 = [zeros(13,4); Bond4];
Re = FF6 - Rf*ones(1,6);
t0 = 2:73;
t1 = 2:31;
t2 = 32:73;
t3 = 14:73;
t4 = 14:44;
t5 = 45:73;
period = t5;
Re = Re(period,:);
Bond4 = Bond4(period,:);
Re = [Bond4, Re];
% Re = Bond4;
F = X(period-7);
T = size(Re,1);
z = ones(T,1);

% GMM Estimate ****************************************************
b0 = regress(Re(:,1),F);
% b0 = [b0; mean(F)'];

gmmopt.infoz.momt = 'gmmmRe';
gmmopt.infoz.jake = 'gmmjRe';
out = gmm(b0,gmmopt,F,Re,z); close all;
% V = inv(out.M'*out.W*out.M)/T;
% [lamda, VLamda] = getLamda(out.b,F,V);
% seLamda = diag(VLamda).^0.5;
% t = lamda ./ seLamda';