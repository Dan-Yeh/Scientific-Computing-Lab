function y_approx = RungeKutta(f, y0, dt, t_end)
% size of approximated y
y_approx_size = t_end/dt + 1; 

% initialization
y_approx = zeros(1,y_approx_size);
y_approx(1) = y0;

for n=1:y_approx_size-1
    f_1 = f(y_approx(n));
    f_2 = f(y_approx(n) + dt*0.5*f_1);
    f_3 = f(y_approx(n) + dt*0.5*f_2);
    f_4 = f(y_approx(n) + dt*f_3);
    
    y_approx(n+1) = y_approx(n) + dt / 6 * (f_1 +2*f_2 + 2*f_3 + f_4);
end

end