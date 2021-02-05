function K = get_state_feedback(B, R, X)
% Provides the state feedback matrix
% 
% Inputs:
%   B       input-to-state matrix
%   R       control
%   X       solution of the PRDE

N = size(X, 3);
no_states = size(B,1);
no_cotrols = size(B,2);
K = zeros(no_cotrols, no_states, N);
for k = 1:N 
    K(:,:,k) = -R(:,:,k)\B(:,:,k)'*X(:,:,k);
end