function [xt, xtd] = trigonometric_matrix_polynomial(t_k, Xa, Xb, M, w)
% Function creates trigonometric matrix polynomial of degree M
% 
% Inputs:
%   Xa        symmetric matrix [n x n x M+1] of coefficints of 
%             polynomial where n - is number of states of linear
%             time varying system; M - degree of polynomial
%   Xb        symmetric matrix [n x n x M] of coefficients
%   t_k       time instant
%   M         polynomial degree
%   w         frequency
% 
% Outputs:
%   xt        symbolics value of polynomial at time instant t_k
%   xtd       symbolics derivative of polynomial at  -/-
 

xt = Xa(:,:,1);             % R_{a,0} [Saetre, p.33]
xtd = zeros(size(Xa,1));    % derivative of R
% build trigonometric polynomial 
% sum_{1}^{M} ( cos[kw*t_{l}]*R_{a,k} + sin[kw*t_{l}]*R_{b,k})
% and its derivative
for k = 1:M
    xt = xt + Xa(:,:,k+1)*cos(w*k*t_k) + Xb(:,:,k)*sin(w*k*t_k);         
    xtd = xtd - w*k*Xa(:,:,k+1)*sin(w*k*t_k) + w*k*Xb(:,:,k)*cos(w*k*t_k);
end
