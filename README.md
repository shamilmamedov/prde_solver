# The Periodic Differential Riccati Equation solver

The solver is the implementation of the algorithm proposed in: 
_Gusev, Sergei V., Anton S. Shiriaev, and Leonid B. Freidovich. "SDP-based approximation of  stabilising solutions for periodic matrix Riccati differential equations." International Journal of Control 89.7 (2016): 1396-1405._

Here is the piece of the abstract that provides high level explanation of the algorithm:
> All previously proposed techniques for solving such equations involve numerical integration of unstable differential equations and consequently fail whenever the period is too large or the coefficients vary too much. Here, a new method for numerical computation of stabilising solutions for matrix differential Riccati equations with periodic coefficients is proposed. Our approach does not involve numerical solution of any differential equations. The approximation for a stabilising solution is found in the form of a trigonometric polynomial,
matrix coefficients of which are found solving a specially constructed finite-dimensional semidefinite programming (SDP) problem. This problem is obtained using maximality property of the stabilising solution of the Riccati equation for the associated Riccati inequality and sampling technique.

The solver requires:
* [YALMIP](https://yalmip.github.io/)
* [SDPT3](https://github.com/sqlp/sdpt3)
make sure that they are installed.

The implementation consists of several functions:
1. prde\_solver\_settings(Name, Value, ...) - creates a structure for prde solver
2. solver\_prde(A, B, Q, R, t, opts) - solves prde and returns trigonometric matrix polynomial coefficients
3. get\_prde\_solution(t, Xa, Xb, M, w) - computes solution of the prde and its derivative at times instants t
4. get\_state\_feedback(B, R, X) - computes state feedback matrix
