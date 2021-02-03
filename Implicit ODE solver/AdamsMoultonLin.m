function y_approx = AdamsMoultonLin(f, y0, dt, t_end)
% AdamsMoultonLin(f, y0, dt, t_end)
% Return an approximation to the solution of ODE y' = f(t, y) using a
% linearized version of the AdamsMoulton scheme
%
%   f   explicit linearized AdamsMoulton function f(y, dt)
%   y0  ODE starting condition
%   dt  timestep
%   t_end   solve until t_end


% size of approximated y
y_approx_size = t_end/dt + 1; 

% initialization
y_approx = zeros(1,y_approx_size);
y_approx(1) = y0;

for n=1:y_approx_size-1
    y_approx(n+1) = f(y_approx(n), dt);
end

end