classdef PDE_solver < handle
    % Class for solving the PDE defined by RightSide
    properties(Access = private)
        RightSide;
        solver;
        ExactSolution;
    end

    methods(Access = public)
        function obj = PDE_solver(RightSide, ExactSolution)
            obj.RightSide = RightSide;
            obj.ExactSolution = ExactSolution;
        end
        
        function [runtimes, storages] = solve(obj, N, method)
            % Solve the PDE via selected method and return runtime and
            % storage numbers
            % Creates surface and contour plots
            if nargin < 2
                method = "SparseMatrix";
            end            
            i = 0;
            runtimes = zeros(size(N));
            storages = zeros(size(N));
            for n=N
                i = i+1;
                Nx=n;
                Ny=n;
                T = zeros(Nx+2, Ny+2);
                b = obj.right_side(Nx, Ny);
                obj.select_method(method);
                [T(2:Nx+1, 2:Ny+1), runtimes(i), storages(i)] = obj.solver(Nx, Ny, b, true);
                obj.create_surf_contour(T, Nx, Ny, method + sprintf(" (N=%d)", n));
            end            
        end
        
        function [error, error_red] = solve_error(obj, N, method)
            % Solves the PDE for all N and returns the errors compared to
            % the exact solution
            if nargin < 3
                method = "GaussSeidel";
            end            
            i=0;
            error = zeros(size(N));
            for n=N
                i = i+1;
                Nx=n;
                Ny=n;
                b = obj.right_side(Nx, Ny);
                obj.select_method(method);
                [T] = obj.solver(Nx, Ny, b, false);
                T_exact = obj.solve_exact(Nx, Ny);
                error(i) = Utilities.compute_error(T, T_exact);
            end
            error_red = NaN(size(error));
            error_red(2:end) = error(1:end-1)./error(2:end);
        end
    end
    
    methods(Access = private) 
        function [T, runtime, storage] = solve_full_matrix(obj, Nx, Ny, b, measure)
            runtime = NaN; storage = NaN;
            f = @() obj.solve_linear_system(Nx, Ny, b, false);
            [T, A] = f();
            if measure
                runtime = timeit(f);
                % Size of A + size of T + size of b
                storage = numel(A) + numel(T) + size(b,1);
            end
        end
        
        function [T, runtime, storage] = solve_sparse_matrix(obj, Nx, Ny, b, measure)
            runtime = NaN; storage = NaN;
            f = @() obj.solve_linear_system(Nx, Ny, b, true);
            [T, A] = f();
            if measure
                runtime = timeit(f);
                % Non zero entries of A + size of T + size of b
                storage = nnz(A) + numel(T) + size(b,1);
            end
        end
        
        function [T, A] = solve_linear_system(obj, Nx, Ny, b, sparse_flag)
            % Extra function, so timeit() can be used
            A = discrete_matrix(Nx, Ny, sparse_flag);
            T = reshape(A\b, [Nx, Ny]);            
        end
        
        function [T, runtime, storage] = solve_gauss_seidel(obj, Nx, Ny, b, measure)
            runtime = NaN; storage = NaN;
            f = @() gauss_seidel_solver(Nx, Ny, b);
            T = f();
            if measure
                runtime = timeit(f);
                % Size of T (with borders) and b
                storage = (size(T,1)+2)*(size(T,2)+2) + size(b,1);
            end
        end
        
        
        function T = solve_exact(obj, Nx, Ny)
            % Calculate the exact T
            [X,Y] = meshgrid((0:Nx+1)/(Nx+1),(0:Ny+1)/(Ny+1));
            T = obj.ExactSolution(X,Y);
            T = T(2:end-1, 2:end-1);
        end

        function select_method(obj, method)
            % Select the solver method
            switch method
                case 'FullMatrix'
                    obj.solver = @obj.solve_full_matrix;
                case 'SparseMatrix'
                    obj.solver = @obj.solve_sparse_matrix;
                case 'GaussSeidel'
                    obj.solver = @obj.solve_gauss_seidel;
                otherwise
                    fprintf("Unknown method '%'", method);
                    return
            end
        end

        function b = right_side(obj, Nx, Ny)
            % Calculate the rightside vector b
            [X,Y] = meshgrid((0:Nx+1)/(Nx+1),(0:Ny+1)/(Ny+1));
            b = obj.RightSide(X,Y);
            b = b(2:end-1, 2:end-1);
            b = reshape(b',[],1);
        end
        
        function create_surf_contour(obj, T, Nx, Ny, name)
            % Create surface and contour plots of solution T
            [X,Y] = meshgrid((0:Nx+1)/(Nx+1),(0:Ny+1)/(Ny+1));
            figure()
            surf(X,Y,T')
            colorbar
            view(3)
            title(name, 'Interpreter', 'none')
            figure()
            contour(X,Y,T', 'ShowText', 'on')
            pbaspect([1 1 1])
            title(name, 'Interpreter', 'none')
        end
    end
    
end