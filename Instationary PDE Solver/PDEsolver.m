classdef PDEsolver < handle
    properties(Access = private)
        MethodName;
        Method;
        dts;
        N = 2.^(2:5)-1;
        plot_t = (1:4)./8;
        openedfigs = 0;
    end
    
    methods
        function obj = PDEsolver()
        end
        function select_method(obj, method)
            obj.MethodName = method;
            obj.policy();
        end
        function stability_table = solve(obj,save)
            len_N = length(obj.N);
            len_dts = length(obj.dts);
            stability = zeros(len_N,len_dts);
            for i = 1:len_N
                for j = 1:len_dts
                    % initialize T with boundary condition
                    T_cur = zeros(obj.N(i)+2);
                    % initialize initial condition
                    T_cur(2:end-1,2:end-1) = 1;
                    
                    for t = 0:obj.dts(j):obj.plot_t(end)
                        T_cur = obj.Method(obj.N(i),obj.N(i),obj.dts(j),T_cur);
                        
                        % plot suface plots of specific time steps
                        if ismember(t,obj.plot_t)
                            index = find(t==obj.plot_t);
                            figure(index+obj.openedfigs)
                            subplot(len_N,len_dts,(i-1)*len_dts+j)
                            obj.plotSurface(obj.N(i),obj.dts(j),T_cur);
                        end
                    end
                    
                    % mark stable solutions
                    stability(i,j) = obj.stability(T_cur);
                end                
            end
            obj.configureFigure(save);
            stability_table = obj.stabilityTable(stability);
            h =  findobj('type','figure');
            obj.openedfigs = length(h);
        end
    end
    
    methods(Access = private)
        function policy(obj)
            switch obj.MethodName
                case 'ExplicitEuler'
                    obj.Method = @ExplicitEuler;
                    obj.dts = 2.^-(6:12);
                case 'ImplicitEuler'
                    obj.Method = @ImplicitEuler;
                    obj.dts = 2^-6;
            end
        end
        function configureFigure(obj, save)
            scr_siz = get(0,'ScreenSize');
            for i = 1:length(obj.plot_t)
                f = figure(i+obj.openedfigs);
                f.Position = scr_siz;
                FigName = sprintf("%s_%d",obj.MethodName,obj.plot_t(i)*1000);
                f.Name = FigName;
                if save
                    print(FigName, '-dpng')
                end
            end
        end
        function plotSurface(obj,Nxy,dt,T_cur)
            x = linspace(0,1,Nxy+2);
            y = linspace(0,1,Nxy+2);
            [X,Y] = meshgrid(x,y); 
            surface(X,Y,T_cur);
            colorbar
            view(3)
            title(sprintf('N=%d, dt=%s',Nxy,strtrim(rats(dt))))
        end
        function res = stability(obj,T)
            %check if all elements in T are between 0~1
            res = all(all(T >= 0 & T <= 1));
        end
        function NewTable = stabilityTable(obj,stability)
            NewTable = table(stability);
            NewTable = splitvars(NewTable);
            NewTable.Properties.RowNames = string(obj.N);
            vars = split(rats(obj.dts));
            NewTable.Properties.VariableNames = vars(2:end-1);
        end
    end
end