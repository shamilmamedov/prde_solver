function test_prde_solver()

[A, B, Q, R, H, t] = benchmark_system();

pol_deg = 25;
opts = prde_solver_settings('pol_deg', pol_deg, ...
                            'alpha', 0, ...
                            'd', 1e+5,...
                            'solver', 'sdpt3');

% get trigonometric matrix polynomials coeffs
[Xa, Xb] = solve_prde(A, B, Q, R, t, opts);

% get prde solutions
[X, ~] = get_prde_solution(t, Xa, Xb, pol_deg, 2*pi/t(end));

nrm = zeros(size(X,3),1);
for i = 1:size(X,3)
    nrm(i) = norm(X(:,:,i) - H(:,:,i)) ;
    assert(nrm(i) < 1e-3);
end

fprintf('Bechmark Example - OK\n');
