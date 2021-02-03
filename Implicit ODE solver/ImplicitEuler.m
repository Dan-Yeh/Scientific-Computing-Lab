function y_approx = ImplicitEuler(f, df, y0, dt, t_end, tol)
% ImplicitEuler(f, df, y0, dt, t_end)
% Return an approximation to the solution of ODE y' = f(t, y) using the
% implicit euler scheme
%
%   f   right hand side function of the ODE
%   df  derivative of f, needed for Newton method
%   y0  ODE starting condition
%   dt  timestep
%   t_end   solve until t_end
% Returns NaN, if system of equation can't be solved with the Newton method

% size of approximated y
y_approx_size = t_end/dt + 1; 

G = @(y, y1) y1 - dt*f(y1) - y;
dG = @(y) 1 - dt*df(y);

% initialization
y_approx = zeros(1,y_approx_size);
y_approx(1) = y0;

for n=1:y_approx_size-1
    root = Newton(G, dG, tol, y_approx(n));
    
    if isnan(root)
        y_approx = NaN;
        break
    else
        y_approx(n+1) = root;
    end
        
end

end