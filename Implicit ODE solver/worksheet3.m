%% Calculate solutions and errors
clear, close all

% Configure ODE
f = @(y)7*(1-y./10).*y;
exact = @(t) 200./(20-10.*exp(-7*t));
df = @(y) -1.4*y + 7;
delta_t = [1/2 1/4 1/8 1/16 1/32];
t_end = 5;
y0 = 20;
lin1 = @(y, dt) (y + 0.5*7*dt*y +0.5*dt*(7*(1-y/10))*y)/(1+dt*y*7/20);
lin2 = @(y, dt) (y + 0.5*dt*(7*(1-y/10))*y)/(1 - 0.5*dt*7*(1-y/10));


% Initialize the main ode solver object
NumMethod = NumericalMethod(exact, df, delta_t, t_end, y0);
NumMethod.setTolerance(1e-4);

NumMethod.selectMethod('ExplicitEuler', f);
[EulerExactError, EulerExactError_RF, EulerStability] = NumMethod.runExactError();

NumMethod.selectMethod('Heun', f);
[HeunExactError, HeunExactError_RF, HeunStability] = NumMethod.runExactError();

NumMethod.selectMethod('ImplicitEuler', f);
[ImplicitEulerExactError, ImplicitEulerExactError_RF, ImplicitEulerStability] = NumMethod.runExactError();

NumMethod.selectMethod('AdamsMoulton', f);
[AdamsMoultonExactError, AdamsMoultonExactError_RF, AdamsMoultonStability] = NumMethod.runExactError();

NumMethod.selectMethod('AdamsMoultonL1', lin1);
[AdamsMoultonL1ExactError, AdamsMoultonL1ExactError_RF, AdamsMoultonL1Stability] = NumMethod.runExactError();

NumMethod.selectMethod('AdamsMoultonL2', lin2);
[AdamsMoultonL2ExactError, AdamsMoultonL2ExactError_RF, AdamsMoultonL2Stability] = NumMethod.runExactError();


%% Create Tables
delta_t = delta_t';
% Explicit Euler method
ExplicitEulerTable =  Utilities.CreateTable(delta_t, EulerExactError, EulerExactError_RF)

% Method of Heun
HeunTable =  Utilities.CreateTable(delta_t, HeunExactError, HeunExactError_RF)

% Implicit Euler method
ImplicitEulerTable =  Utilities.CreateTable(delta_t, ImplicitEulerExactError, ImplicitEulerExactError_RF)

% Adams Moulton method
AdamsMoultonTable =  Utilities.CreateTable(delta_t, AdamsMoultonExactError, AdamsMoultonExactError_RF)

% Adams Moulton method linearization 1
AdamsMoultonL1Table =  Utilities.CreateTable(delta_t, AdamsMoultonL1ExactError, AdamsMoultonL1ExactError_RF)

% Adams Moulton method linearization 2
AdamsMoultonL2Table =  Utilities.CreateTable(delta_t, AdamsMoultonL2ExactError, AdamsMoultonL2ExactError_RF)

% Stability table
StabilityTable = table(delta_t, ...
    EulerStability, HeunStability, ...
    ImplicitEulerStability, AdamsMoultonStability, ...
    AdamsMoultonL1Stability, AdamsMoultonL2Stability)

