classdef ExplicitNumericalMethod < handle
    properties(Access = private)
        ExactSolution;
        ODE;
        InitialValue;
        MethodName;
        NumericalMethod;
        dts = [1 1/2 1/4 1/8];
        t_end = 5;
    end
    
    methods
        function obj = ExplicitNumericalMethod()
            obj.ExactSolution = @(t) 10./(1+9.*exp(-t));
            obj.ODE = @(y)(1-y./10).*y;
            obj.InitialValue = 1;
        end
        function selectMethod(obj, method)
            obj.MethodName = method;
            obj.policy();
        end
        function [ExactError, ReducedFactor] = runExactError(obj)
            figure('Name', obj.MethodName) % 'Name', obj.MethodName
            hold on
            ExactError = zeros(size(obj.dts,2),1);
            color = Utilities.getColors();
            for i = 1:size(obj.dts,2)
                t = 0: obj.dts(i) :obj.t_end;
                p = obj.ExactSolution(t);
                
                yApprox = obj.NumericalMethod(obj.ODE, obj.InitialValue, obj.dts(i), obj.t_end); % obj.NumericalMethod
                
                ExactError(i) = Utilities.rmse(yApprox,p, obj.dts(i), obj.t_end);
                
                plot(t, yApprox,color(i+1), 'DisplayName', sprintf('dt=%g', obj.dts(i)))
            end
            plot(t, p ,color(1), 'DisplayName', 'Exact solution p(t)')
            title(obj.MethodName)
            legend('Location','northwest')
            
            tmp = [ExactError(1); ExactError(1:end-1)]; 
            ReducedFactor = ExactError ./ tmp;
        end
        function ApproxError = runApproxError(obj)
            ApproxError = zeros(size(obj.dts,2),1);
            p = obj.NumericalMethod(obj.ODE, obj.InitialValue, obj.dts(end), obj.t_end);
            ApproxError(end) = 0;
            for i = 1:size(obj.dts,2)-1
                
                yApprox = obj.NumericalMethod(obj.ODE, obj.InitialValue, obj.dts(i), obj.t_end);
                
                interval = 1/obj.dts(end)*obj.dts(i);
                ApproxError(i) = Utilities.rmse(yApprox,p(1:interval:end), obj.dts(i), obj.t_end);
            end
        end
    end
    
    methods(Access = private)
        function policy(obj)
            switch obj.MethodName
                case 'ExplicitEuler'
                    obj.NumericalMethod = @ExplicitEuler;
                case 'Heun'
                    obj.NumericalMethod = @Heun;
                case 'RungeKutta'
                    obj.NumericalMethod = @RungeKutta;
            end
        end
    end
end