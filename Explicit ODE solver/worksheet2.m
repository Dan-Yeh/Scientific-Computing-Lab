%% Worksheet 2 c) i)ii)iii)
ExpNumMethod = ExplicitNumericalMethod();

ExpNumMethod.selectMethod('ExplicitEuler');
[EulerExactError, EulerExactError_RF] = ExpNumMethod.runExactError();

ExpNumMethod.selectMethod('Heun');
[HeunExactError, HeunExactError_RF] = ExpNumMethod.runExactError();

ExpNumMethod.selectMethod('RungeKutta');
[RungeKuttaExactError, RungeKuttaExactError_RF] = ExpNumMethod.runExactError();

%% Worksheet 2 c) iv)
ExpNumMethod = ExplicitNumericalMethod();

ExpNumMethod.selectMethod('ExplicitEuler');
EulerApproxError = ExpNumMethod.runApproxError();

ExpNumMethod.selectMethod('Heun');
HeunApproxError = ExpNumMethod.runApproxError();

ExpNumMethod.selectMethod('RungeKutta');
RungeKuttaApproxtError = ExpNumMethod.runApproxError();

%% Create Tables
delta_t = [1; 1/2; 1/4; 1/8];
% Explicit Euler method (q = 1)
ExplicitEulerTable =  Utilities.CreateTable(delta_t, EulerExactError, EulerExactError_RF, EulerApproxError)

% Method of Heun (q = 2)
HeunTable =  Utilities.CreateTable(delta_t, HeunExactError, HeunExactError_RF, HeunApproxError)

% Runge-Kutta method (q = 4)
RungeKuttaTable =  Utilities.CreateTable(delta_t, RungeKuttaExactError, RungeKuttaExactError_RF, RungeKuttaApproxtError)

