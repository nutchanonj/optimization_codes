function [f,gradient,Hessian] = FunctionName(x, options)
    
    % Declare the functions.
    f_fun = @(x) 100*(x(2) - x(1)^2)^2 + (1-x(1))^2;
    gradient_fun = @(x)[400*x(1)*(x(1)^2 - x(2)) - 2*(1-x(1)); 200*(x(2)-x(1)^2)];
    Hessian_fun = @(x)[2 - 400*(x(2)-3*x(1)^2), -400*x(1); -400*x(1), 200] ;

    % Evaluate numerical values.
    switch options
        case 1 % calculate only f.
            f = f_fun(x);
            gradient = 0;
            Hessian = 0;
        case 2
            f = f_fun(x); % calculate f and gradient.
            gradient = gradient_fun(x);
            Hessian = 0;
        case 3
            f = f_fun(x); % calculate f, gradient and Hessian.
            gradient = gradient_fun(x);
            Hessian = Hessian_fun(x);
        otherwise % invalid option.
            disp('invalid option.') 
            f = 0; gradient = 0; Hessian = 0;
    end
end