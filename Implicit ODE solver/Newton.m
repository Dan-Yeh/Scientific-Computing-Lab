function root = Newton(G, dG, tol, y0, max_iter)
% Newton(G, dG, tol, y0, max_iter)
% Finds the root to function G iteratively 
% by solving the equation y_next = y - G(y)/dG(y)
%
%   G   function to find the root of
%   dG  first derivative of G
%   y0  first iteration value
%   limit   Stop method after reaching limit
%   max_iter    maximum number of iterations performed
%
% Returns NaN if dG turns 0 or the limit is not reached within max_iter
% iterations

if nargin < 5
    max_iter = 100;
    if nargin < 4
        y0 = 0;
        if nargin < 3
            tol = 1e-4;
        end
    end
end

y = y0;

for i=1:max_iter
    tmp_diff = dG(y);
    % Stop newton when dG is 0 
    if tmp_diff == 0
        root = NaN;
        return        
    end
    
    y1 = y - G(y0, y)/tmp_diff;
    
    if abs(y1-y) < tol
        root = y1;
        return
    end
    y = y1;
end
% tolerance limit has not been reached within set max_iter
root = NaN;
end

