function [ Income ] = getIncome( I, indexI, base )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    indexI = indexI / base;
    Income = indexI * I;

end

