function [f,J] = FunctionName(xin)
    
    % Declare the functions.
    f_fun = @(x) 40*(x-1)^3 - 12*cos(3*x);
    J_fun = @(x) 120*(x-1)^2 + 36*sin(3*x);

    % Evaluate numerical values.
    f = f_fun(xin);
    J = J_fun(xin);

end