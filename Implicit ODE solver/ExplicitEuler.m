function y_approx = ExplicitEuler(f, y0, dt, t_end)
% ExplicitEuler(f, y0, dt, t_end)
% Return an approximation to the solution of ODE y' = f(t, y) using the
% explicit euler scheme
%
%   f   right hand side function of the ODE
%   y0  ODE starting condition
%   dt  timestep
%   t_end   solve until t_end

% size of approximated y
y_approx_size = t_end/dt + 1; 

% initialization
y_approx = zeros(1,y_approx_size);
y_approx(1) = y0;

for n=1:y_approx_size-1
    y_approx(n+1) = y_approx(n) + dt * f(y_approx(n));
end

end