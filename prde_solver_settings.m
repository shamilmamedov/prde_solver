function options = prde_solver_settings(varargin)
% Create prde solver settings
% 
% Properties:
%   pol_deg   degree of trigonometric polynomial that servers as a basis
%             for the solution of the prde
%   alpha     guaranteed convergence rate i.e. the eigenvalues of the 
%             closed loop system are going to be on the left of alpha
%   d         limit on the solution of prde
%   solver    solver to be used by YALMIP

names = ["pol_deg", "alpha", "d", "solver"];
m = length(names);

% combine
options = [];
for j = 1:m
  options.(names(j)) = [];
end

if rem(nargin,2) ~= 0
  error("Name and value mismatch");
end

i = 1;
expectval = 0;                          % start expecting a name, not a value
while i <= nargin
  arg = varargin{i};
    
  if ~expectval
    if ~ischar(arg)
      error("Not a proper name %s", arg);
    end
    
    j = find(names == string(arg));
    if isempty(j)                       % if no matches
      error("Invalid name %s", arg);
    end
    expectval = 1;                      % we expect a value next
  else
    options.(names(j)) = arg;
    expectval = 0;
      
  end
  i = i + 1;
end

