function [X, Xd] = get_prde_solution(t, X1, X2, M, w)
% Provides the solution of the prde and its derivative
% 
% Inputs:
%   t       time instants at which the solution is required
%   X1      cosine coeffs of the trigonometric matrix polynomial
%   X2      sine coeffs of the trigonometric matrix polynomial
%   M       degree of the trigonometric matrix polynomial
%   w       fundamental frequency of the trigonometric matrix polynomial
%
%   Outputs:
%   X       solutions of the prde
%   Xd      time derivatives of the solutions of the prde

N = length(t);
no_states = size(X1, 1);
% Allocating memory for output matrices
X = zeros(no_states, no_states, N);
Xd = zeros(no_states, no_states, N);
for k = 1:N %for each time step
    [X(:,:,k), Xd(:,:,k)] = trigonometric_matrix_polynomial(t(k), X1, X2, M, w);
end
