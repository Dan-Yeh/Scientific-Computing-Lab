classdef Utilities
    methods(Static)
        function colorset = getColors()
            colorset = ["k-", "r-", "g-", "b-", "m-", "c-", "y-"];
        end
        function res = rmse(x,y, dt, t_end)
            res = sqrt((dt/t_end) * sum((x-y).^2, 'all'));
        end
        function NewTable = CreateTable(delta_t, error, error_red, error_app)
            NewTable = rows2vars(table(error, error_red, error_app));            
            NewTable.Properties.VariableNames = ['delta_t' string(delta_t')];
        end
    end
end