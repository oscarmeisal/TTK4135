function [c,ceq] = NonLinConstraint(z, alfa, beta, lambda_t, mx, N)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
% z = [x0, x1, ..., xn, u0, u1, ..., un]
lambda_k = z(1:mx:N*mx);
e_k = z(5:mx:N*mx);
c = alfa*exp(-beta*(lambda_k-lambda_t).^2)-e_k;
ceq = [];
end