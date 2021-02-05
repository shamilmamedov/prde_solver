function [A, B, Q, R, H, t] = benchmark_system()

% This bechmark example is taken from Gusevs paper
% of 2015 that is taken from somewhere else

A_c = [4 3; -4.5 -3.5];
B_c = [1;-1];
R_c = 1;
Q_c1 = [9,6; 6 4];
Q_c2 = Q_c1 + [1 0; 0 0];
Q_c3 = Q_c1 - [1 0; 0 0];

H_c = care(A_c,B_c,Q_c1,R_c,zeros(2,1),eye(2,2));
H_c = H_c';

p11_fcn = @(t) 1./(1.5 + cos(2*pi*t)).*cos(2*pi*t);
p12_fcn = @(t) 1./(1.5 + cos(2*pi*t)).*sin(2*pi*t);
p21_fcn = @(t) 1./(1.5 + cos(2*pi*t)).*(-sin(2*pi*t));
p22_fcn = @(t) 1./(1.5 + cos(2*pi*t)).*cos(2*pi*t);

% Finding derivative of matrix P
syms tt   real
pd11_fcn = matlabFunction(diff(@(tt)p11_fcn(tt),tt));
pd12_fcn = matlabFunction(diff(@(tt)p12_fcn(tt),tt));
pd21_fcn = matlabFunction(diff(@(tt)p21_fcn(tt),tt));
pd22_fcn = matlabFunction(diff(@(tt)p22_fcn(tt),tt));

T = 1;
N = 100; %Time instarnces
dt = T/N;
t = 0:dt:T;

%constructing P matrix
P = zeros(2,2,N);
Pd = zeros(2,2,N);
A = zeros(2,2,N);
B = zeros(2,1,N);
Q = zeros(2,2,N);
R = zeros(1,1,N);
H = zeros(2,2,N);
for i =1:length(t)
    t_i = t(i);
    P(:,:,i) = [p11_fcn(t_i), p12_fcn(t_i); p21_fcn(t_i), p22_fcn(t_i)];
    Pd(:,:,i) = [pd11_fcn(t_i), pd12_fcn(t_i); pd21_fcn(t_i), pd22_fcn(t_i)];
    A(:,:,i) = P(:,:,i)\A_c*P(:,:,i) - P(:,:,i)\Pd(:,:,i);
    B(:,:,i) = P(:,:,i)\B_c;
    Q(:,:,i) = P(:,:,i)'*Q_c1*P(:,:,i);
    R(:,:,i) = R_c;
    H(:,:,i) = P(:,:,i)'*H_c*P(:,:,i);
end

