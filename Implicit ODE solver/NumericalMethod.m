classdef NumericalMethod < handle
    % Class to solve an ODE numerically with selected schemes
    properties(Access = private)
        ExactSolution;
        ODE;
        InitialValue;
        RhsDerivative;
        MethodName;
        Method;
        t_end;
        dts;
        tol = 1e-4;
        implicit_flag;
    end
    
    methods
        function obj = NumericalMethod(exact, df, dt, t_end, y0)
            obj.ExactSolution = exact;
            obj.RhsDerivative = df;
            obj.dts = dt;
            obj.t_end = t_end;
            obj.InitialValue = y0;
        end
        
        function selectMethod(obj, method, ode)
            % Switch to select solving scheme
            % Must be called before runExactError()
            obj.MethodName = method;
            obj.ODE = ode;
            obj.policy();
        end
        
        function setTolerance(obj, tol)
            obj.tol = tol;
        end
        
        function [ExactError, ReducedFactor, Stability] = runExactError(obj)
            % Compute the aprroximated solution to the ODE using the
            % selected solving scheme with all the timesteps in dt vector
            % plot the solutions together with the exact solutions
            % Returns
            %   ExactError  rmse error between approximation and exact
            %               solution
            %   ReducedFactor   factor of how much the exact error is
            %                   reduced between different timesteps
            %   Stability   "X" if the approx. solution is stable, "-"
            %               otherwise
            
            figure('Name', obj.MethodName)
            hold on
            ExactError = zeros(size(obj.dts,2),1);
            Stability = strings(size(obj.dts))';
            color = Utilities.getColors();
            % iterate over all desired timestep sizes
            for i = 1:size(obj.dts,2)
                t = 0: obj.dts(i) :obj.t_end;
                p = obj.ExactSolution(t);
                
                if obj.implicit_flag
                    yApprox = obj.Method(obj.ODE, obj.RhsDerivative, obj.InitialValue, obj.dts(i), obj.t_end, obj.tol);
                else
                    yApprox = obj.Method(obj.ODE, obj.InitialValue, obj.dts(i), obj.t_end);
                end
                
                % handling if Newton method didn't converge
                if isnan(yApprox)
                    ExactError(i) = NaN;
                    Stability(i) = "-";
                    continue
                end
                ExactError(i) = Utilities.rmse(yApprox,p, obj.dts(i), obj.t_end);
                Stability(i) = Utilities.checkStability(yApprox, p, obj.tol);
                plot(t, yApprox,color(i+1), 'DisplayName', sprintf('dt=%g', obj.dts(i)))
            end
            
            % Configure plot
            plot(t, p ,color(1), 'DisplayName', 'Exact solution p(t)')
            xlim([0 5])
            ylim([0 20])
            title(obj.MethodName)
            legend('Location','northeast')
            
            % Calculate the error and reduction factor
            Denominator = [ExactError(1); ExactError(2:end)];
            Numerator = [0; ExactError(1:end-1)]; 
            ReducedFactor = Numerator ./ Denominator;
            
        end

    end
    
    
    methods(Access = private)
        function policy(obj)
            switch obj.MethodName
                case 'ExplicitEuler'
                    obj.Method = @ExplicitEuler;
                    obj.implicit_flag = false;
                case 'Heun'
                    obj.Method = @Heun;
                    obj.implicit_flag = false;
                case 'ImplicitEuler'
                    obj.Method = @ImplicitEuler;
                    obj.implicit_flag = true;
                case 'AdamsMoulton'
                    obj.Method = @AdamsMoulton;
                    obj.implicit_flag = true;
                case 'AdamsMoultonL1'
                    obj.Method = @AdamsMoultonLin;
                    obj.implicit_flag = false;
                case 'AdamsMoultonL2'
                    obj.Method = @AdamsMoultonLin;
                    obj.implicit_flag = false;
            end
        end
    end
end