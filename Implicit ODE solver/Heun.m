function y_approx = Heun(f, y0, dt, t_end)
% Heun(f, y0, dt, t_end)
% Return an approximation to the solution of ODE y' = f(t, y) using the
% heun scheme
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
    f_yn = f(y_approx(n));
    f_yn1 = f(y_approx(n) + dt*f_yn);
    y_approx(n+1) = y_approx(n) + dt * 0.5 * (f_yn + f_yn1);
end

end