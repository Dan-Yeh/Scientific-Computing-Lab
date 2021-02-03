function T_next = ImplicitEuler(Nx,Ny,dt,T_cur)
hx = 1/(Nx+1);
hy = 1/(Ny+1);
max_iter = 1e3;
acc = 1e-6;

iter = 0;
resnorm = inf;
T_next = T_cur;
while resnorm > acc && iter < max_iter
    for y=2:Ny+1
        for x=2:Nx+1
            Tx = (T_next(y,x-1)+T_next(y,x+1)) / hx^2;
            Ty = (T_next(y-1,x)+T_next(y+1,x)) / hy^2;
            T_next(y,x) = (T_cur(y,x) + dt*(Tx+Ty)) / (1+2*dt*(1/hx^2+1/hy^2));
        end
    end
    resnorm = residual_norm(Nx,Ny,hx,hy,T_next,T_cur,dt);
    iter = iter + 1;
end

end

function resnorm = residual_norm(Nx,Ny,hx,hy,T_next,T_cur,dt)
sum = 0;
for y=2:Ny+1
    for x=2:Nx+1
        Tx = (T_next(y,x-1)+T_next(y,x+1)) / hx^2;
        Ty = (T_next(y-1,x)+T_next(y+1,x)) / hy^2;
        T_approx = T_cur(y,x) + dt*(Tx+Ty) / (1+dt*(1/hx^2+1/hy^2));
        sum = sum + (T_next(y,x)-T_approx).^2;
    end
end
resnorm = sqrt(sum/(Nx*Ny));
end