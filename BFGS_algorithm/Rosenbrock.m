function [f,gradient] = Rosenbrock(x,options)
    
    % Declare the functions.
    f_fun = @(x) 100*(x(2) - x(1)^2)^2 + (1-x(1))^2;
    gradient_fun = @(x)[400*x(1)*(x(1)^2 - x(2)) - 2*(1-x(1)); 200*(x(2)-x(1)^2)];

    % Evaluate numerical values.
    switch options
        case 1 % calculate only f.
            f = f_fun(x);
            gradient = 0;
        case 2 % calculate f and gradient.
            f = f_fun(x); 
            gradient = gradient_fun(x);
        otherwise % invalid option.
            disp('invalid option.') 
            f = 0; gradient = 0;
    end

end