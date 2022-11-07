function [xmin, fmin, IFLAG, nF, nG] = golden(FunctionName, a, b, e_rel, e_abs, s, itmax )

    % -------------- Function inputs --------------
    %
    % FunctionName: function to return the value, the gradient, and the Hessian 
    % of the particular function. 
    %   Mode 1: return only f.
    %   Mode 2: return f and gradient.
    %   Mode 3: return f, gradient and Hessian.
    %
    % a, b : interval of searching.
    %
    % e_rel, e_abs: the parameters used in the stopping criterion for line search. 
    % (abs(dot(s,gradient_x2)) <= abs(dot(s,gradient_x1))*e_rel + e_abs)
    %
    % s: search direction. (s = -Hessian\gradient for Newton, s = -gradient for Steepest.)
    %
    % itmax: max allowed number of iterations.
    
    % -------------- Function outputs --------------
    %
    % xmin, fmin: returned minimum function argument and value, respectively.
    %
    % IFLAG: indicate the success. 0 if success, -999 otherwise.
    %
    % nF, nG: numbers of f and gradient calculations.

    tau = double((sqrt(5)-1)/2);    % golden ratio.
    k = 0;                          % number of iterations.

    % computing x1, x2 values.
    x1=a+(1-tau)*(b-a);             
    x2=a+tau*(b-a);
    
    % computing f values at x1, x2
    [f_a, ~, ~] = FunctionName(a,1); 
    [f_b, g_b, ~] = FunctionName(b,2);
    [f_x1, gradient_x1, ~] = FunctionName(x1,2);        
    [f_x2, gradient_x2, ~] = FunctionName(x2,2);

    nF = 4; % number of f calculations.
    nG = 3; % number of gradient calculations.

    if (dot(g_b,s) > 0) % check if the interval is ok, the end point must have positive slope.
        disp("This [a,b] interval is good.");

        % check whether the condition is satisfied or not.
        while ((abs(dot(s,gradient_x2)) > abs(dot(s,gradient_x1))*e_rel + e_abs) && (k < itmax))

            k = k + 1; % new iteration.
            
            % calculate new values according to the rules...
            if (f_x1 < f_x2)
                b=x2;
            else                
                a=x1;
            end

            % computing new x1, x2 values.
            x1=a+(1-tau)*(b-a); 
            x2=a+tau*(b-a);

            % computing f values at new x1, x2.
            [f_x1, gradient_x1, ~] = FunctionName(x1,2);   
            [f_x2, gradient_x2, ~] = FunctionName(x2,2);
            nF = nF + 2; 
            nG = nG + 2; 

            % For debugging purposes.
            % fprintf('dot(s,gradient_x2) is %.11f \n',abs(dot(s,gradient_x2)))
            % fprintf('dot(s,gradient_x1) is %.11f \n',abs(dot(s,gradient_x1)))

        end

        if (k == itmax) % Exceed allowed number of iterations.
            disp("too many iterations");
            IFLAG = -999;
        else
            disp("success!"); % Success.
            IFLAG = 0;
        end

        xmin = (x1+x2)/2; % return argmin.
        [fmin, ~, ~] = FunctionName(xmin,1); nF = nF + 1; % return min of f.

    else % the interval is not satisfied.
        disp("This [a,b] interval is not good. Please change the interval.");
        disp(g_b)
        IFLAG = -999;
        xmin = 0; fmin = 0;
    end

end
