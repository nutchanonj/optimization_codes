function [f,J] = FunctionName(xin)
    
    % Declare the functions.
    f_fun = @(x)[x(1)^2+x(2)^2-1;5*x(1)^2-x(2)-2];
    J_fun = @(x)[2*x(1),2*x(2);10*x(1),-1];

    % Evaluate numerical values.
    f = f_fun(xin);
    J = J_fun(xin);

end