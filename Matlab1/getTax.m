function [ tax ] = getTax( I,C,t )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    It = I-C;
    It = It.*(It>0);

    maxI = max(It);
    tax = It.*(It/maxI*t);

end

