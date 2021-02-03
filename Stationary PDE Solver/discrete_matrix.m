function A = discrete_matrix(Nx, Ny, sparse_flag)
    % Create the discrete matrix for our pde problem
    % sparse_flag   Use a sparse matrix representation
    % Grid schematic diagram
    %  .T12 .T22 .T32
    %  .T11 .T21 .T31
    % x = [T11 T21 T31 T12 T22 T32]'

    if nargin < 3
        sparse_flag = false;
    end
    hx = 1/(Nx+1);
    hy = 1/(Ny+1);
    N = Nx*Ny;

    if sparse_flag == true
            A = sparse(N,N);
    else
            A = zeros(N);
    end
    
    
    for i=1:N
        A(i,i) = -2*(1/hx^2 + 1/hy^2);
        % Check if the point is on left boundary
        if (mod(i-1, Nx) ~= 0)
            A(i,i-1) = 1/hx^2;
        end
        % Check if the point is on right boundary
        if (mod(i, Nx) ~= 0)
            A(i,i+1) = 1/hx^2;
        end
        % Check if the point is on lower boundary
        if (i > Nx)
            A(i,i-Nx) = 1/hy^2;
        end
        % Check if the point is on upper boundary
        if (i <= N-Nx)
            A(i,i+Nx) = 1/hy^2;
        end
    end
end