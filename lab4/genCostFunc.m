function theta = genCostFunc(z,Q)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
theta = z'*Q*z;
end