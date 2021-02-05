function [X1, X2] = solve_prde(A, B, Q, R, t, opts)
% The function solves Periodic Differential Riccati equation for 
% continous time systems by approximating solution with matrix
% trigonometric polynomials. The Periodic Differential Riccati equation
% is imposed at a chosen time instants as LMI such that its Schur
% compliment is equal to PDRE. Optimization solves for matrix
% trigonometric polynomial coeffients. Once the optimizator converges
% we can compute the solution of PDRE at any times instant, thus
% state feedback matrix
% 
% Gusev, Sergei V., Anton S. Shiriaev, and Leonid B. Freidovich. 
% "SDP-based approximation of stabilising solutions for periodic matrix 
% Riccati differential equations." 
% International Journal of Control 89.7 (2016): 1396-1405.

% parse options
if isempty(opts.pol_deg)
    M = 20;
else
    M = opts.pol_deg;
end

if isempty(opts.alpha)
    alpha = 0;
else
    alpha = opts.alpha;
end

if isempty(opts.d)
    d = 0; % boundaries on solution
else
    d = opts.d;
end

if isempty(opts.solver)
    solver = 'sdpt3'; 
else
    solver = opts.solver;
end

% compute missing variables from given ones
T = t(end); 
N = length(t);
w = 2*pi/T; % Frequency
no_states = size(A,1);  


J = 0; % Objective function
C = []; % Constraints

% Create variables for matrix coeffients of polynomials
Xa = sdpvar(no_states, no_states, M + 1); 
Xb = sdpvar(no_states, no_states, M);

% Compose constraints and cost function for prde
for k = 1:1:N %for each time step
    % Evaluate trigonometric poynomial at time t_k
    [xt, xtd] = trigonometric_matrix_polynomial(t(k), Xa, Xb, M, w);
   
    J = J + trace(xt);

    Ct = [xtd + A(:,:,k)'*xt + xt*A(:,:,k) + 2*alpha*xt + Q(:,:,k), ... %
          xt*B(:,:,k); B(:,:,k)'*xt R(:,:,k)]; 
    
    C = [C, Ct >= 0, xt >= -d*eye(no_states), xt<=d*eye(no_states)];
end

sdp_opts = sdpsettings('solver', solver, 'sdpt3.maxit' ,250, 'verbose', 0);
diagnostics = optimize(C, -J, sdp_opts);
if diagnostics.problem ~= 0
   error('The solver was not able to solve periodic differential Riccati equation!') 
end

X1 = value(Xa);
X2 = value(Xb);
