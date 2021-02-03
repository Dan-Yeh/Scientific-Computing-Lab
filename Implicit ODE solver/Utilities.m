classdef Utilities
    % Utilities class as a container for several smaller functions
    methods(Static)
        function colorset = getColors()
            % custom colorset for better plot visibility
            colorset = ["k-", "r-", "g-", "b-", "m-", "c-", "y-"];
        end
        function res = rmse(x,y, dt, t_end)
            % Calculate the error between exact and approximated ODE
            % solution
            res = sqrt((dt/t_end) * sum((x-y).^2, 'all'));
        end
        function NewTable = CreateTable(delta_t, error, error_red)
            % Create the error tables
            NewTable = rows2vars(table(error, error_red));            
            NewTable.Properties.VariableNames = ['delta_t' string(delta_t')];
        end
        function res = checkStability(y_approx, y_exact, tol)
            % Compare the approximation to the exact solution
            loc_err = abs(y_exact - y_approx);
            
            if (sum(diff(loc_err) > 2*tol) > 2) %>2 to deal with initial value problem
                res = "-";
            else
                res = "X";
            end
        end

    end
end