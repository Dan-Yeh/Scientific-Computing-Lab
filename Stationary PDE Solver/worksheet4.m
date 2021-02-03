% !! Timing the methods is done with matlabs timeit() function which runs
% the method multiple times. Estimated total script runtime: 10 secs !!

% Runtimes could be reduced slightly by using a linearized vector
% representation for the solution T. For convenience during visualization T
% is instead returned in a matrix shape.

% The system for question a) is sketched in the attached gauss_seidel_system.pdf

%% Initialisation
clear
close all
N = [3 7 15 31 63];
rhs = @(x,y) -2*pi^2*sin(pi*x).*sin(pi*y);
exact = @(x,y) sin(pi*x).*sin(pi*y);
pde_solver = PDE_solver(rhs, exact);

%% Direct full matrix solver
[runtime_full, storage_full] = pde_solver.solve(N, 'FullMatrix');
FullMatrix = Utilities.create_table(runtime_full(2:end), storage_full(2:end), N(2:end))

%% Direct sparse matrix solver
[runtime_sparse, storage_sparse] = pde_solver.solve(N, 'SparseMatrix');
SparseMatrix = Utilities.create_table(runtime_sparse(2:end), storage_sparse(2:end), N(2:end))

%% Gauss-Seidel solver
[runtime_gs, storage_gs] = pde_solver.solve(N, 'GaussSeidel');
GaussSeidel = Utilities.create_table(runtime_gs(2:end), storage_gs(2:end), N(2:end))


%% Gauss-Seidel error table
N = [7, 15, 31, 63, 127];
[error, error_red] = pde_solver.solve_error(N);
GaussSeidelError = Utilities.error_table(N, error, error_red)
