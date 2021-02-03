function T_next = ExplicitEuler(Nx,Ny,dt,T_cur)
hx = 1/(Nx+1);
hy = 1/(Ny+1);

T_next = T_cur;
for y=2:Ny+1
    for x=2:Nx+1
        Txx = (T_cur(y,x-1)-2*T_cur(y,x)+T_cur(y,x+1))/hx^2;
        Tyy = (T_cur(y-1,x)-2*T_cur(y,x)+T_cur(y+1,x))/hy^2;
        T_next(y,x) = dt*(Txx+Tyy) + T_cur(y,x);
    end
end

end
