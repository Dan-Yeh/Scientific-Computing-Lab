classdef Utilities
    % Utilities class as a container for several smaller functions
    methods(Static)
        function colorset = getColors()
            % custom colorset for better plot visibility
            colorset = ["k-", "r-", "g-", "b-", "m-", "c-", "y-"];
        end
        function e = compute_error(T, T_exact)
            % Calculate the error between exact and approximated PDE
            % solution
            [Ny, Nx] = size(T);
            e = sqrt(1/(Ny*Nx) * sum((T-T_exact).^2, 'all'));
        end
        
        function NewTable = create_table(runtime, storages, N)
            % Create the runtime/storage table
            runtime = runtime';
            storages = storages';
            NewTable = rows2vars(table(runtime, storages));
            NewTable.Properties.VariableNames = ['Nx,Ny' string(N)];
        end

        function NewTable = error_table(N, error, error_red)
            % Create the error table
            error = error';
            error_red = error_red';
            NewTable = rows2vars(table(error, error_red));
            NewTable.Properties.VariableNames = ['Nx=Ny' string(N)];
        end
    end
end