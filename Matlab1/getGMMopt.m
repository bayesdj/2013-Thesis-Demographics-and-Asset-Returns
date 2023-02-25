function [ gmmopt ] = getGMMopt( momt,jake,iter )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    if nargin < 3, iter = 11; end;
    gmmopt.gmmit = iter;
    gmmopt.S = 'NW';
    gmmopt.W0 = 'I';
    gmmopt.infoz.momt = momt;
    gmmopt.infoz.jake = jake;
    gmmopt.plot = 0;
end