function theta = genCostFunc(z,Q)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
theta = 1/2 * z'*Q*z;
end