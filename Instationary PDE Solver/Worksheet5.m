%% Worksheet 5
clear
close all

pde_solver = PDEsolver();

%% Worksheet 5 b)c) 
% visualize the solutions 
pde_solver.select_method('ExplicitEuler')
explicit_euler = pde_solver.solve(false)


%% Worksheet 5 d)e)
% visualize the solutions 
pde_solver.select_method('ImplicitEuler')
implicit_euler = pde_solver.solve(false)

