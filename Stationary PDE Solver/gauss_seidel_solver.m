function T = gauss_seidel_solver(Nx, Ny, b)
    % Solve the PDE problem via Gauss-Seidel method
    % Finish when the residual norm is smaller than 1e-4
    hx = 1/(Nx+1);
    hy = 1/(Ny+1);
    max_iter = 1e5;
    
    T = zeros(Nx+2, Ny+2);
    iter = 0;
    while residual_norm(Nx, Ny, T, b) > 1e-4 && iter < max_iter
        iter = iter + 1;
        for y=2:Ny+1
            for x=2:Nx+1
                T(x,y) = ( b((y-2)*Nx+x-1) ...
                        - (T(x,y-1)+T(x,y+1)) / hy^2 ...
                        - (T(x-1,y)+T(x+1,y)) / hx^2 ) ...
                        / (-2*(1/hx^2+1/hy^2));
            end
        end
    end
    
    T = T(2:end-1, 2:end-1);
end

function res = residual_norm(Nx, Ny, T, b)
    % Calculate the residual norm |b-A*T|
    hx = 1/(Nx+1);
    hy = 1/(Ny+1);
    sum = 0;
    for y=2:Ny+1
        for x=2:Nx+1
            T_approx = -2*(1/hx^2+1/hy^2)*T(x,y) ...
                       + (T(x,y-1)+T(x,y+1))/hy^2 ... 
                       + (T(x-1,y)+T(x+1,y))/hx^2;
            
            sum = sum + (b((y-2)*Nx+x-1) - T_approx)^2;
        end
    end
    res = sqrt(sum/(Nx*Ny));
end