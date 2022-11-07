function [xmin,fmin,Xk,Fk,Gk,nF,nG,nH,IFLAG] = Newton(FunctionName,x0,epsilon,e_rel,e_abs,itmax)

    % -------------- Function inputs --------------
    %
    % FunctionName: function to return the value, the gradient, and the Hessian 
    % of the particular function. 
    %   Mode 1: return only f.
    %   Mode 2: return f and gradient.
    %   Mode 3: return f, gradient and Hessian.
    %
    % x0: starting point of searching.
    %
    % epsilon: stoping criterion of the minimum search. (norm(x1-x0) < epsilon.)
    %
    % e_rel, e_abs: the parameters used in the stopping criterion for line search. 
    % (abs(dot(s,gradient_x2)) <= abs(dot(s,gradient_x1))*e_rel + e_abs)
    %
    % itmax: max allowed number of iterations.

    % -------------- Function outputs --------------
    %
    % xmin, fmin: returned minimum function argument and value, respectively.
    %
    % Xk ,Fk, Gk: arrays to keep f, gradient and Hessian along the search steps.
    %
    % nF, nG, nH: numbers of f, gradient and Hessian calculations.
    %
    % IFLAG: indicate the success. 0 if success, -999 otherwise.

    Xk = []; % list to store x_k.
    Fk = []; % list to store f_k.
    Gk = []; % list to store J_k.

    nF = 0; % number of f calculations.
    nG = 0; % number of gradient calculations.
    nH = 0; % number of Hessian calculations. 

    IFLAG = 0; % IFLAG: indicate the success.

    for i = 1:itmax
        [f0,gradient0,Hessian0] = FunctionName(x0, 3); 
        nF = nF+1; nG = nG+1; nH = nH+1;

        % First, using Newton's method.
        s = -Hessian0\gradient0; % search direction.
        disp('Doing Newton.')

        % since we don't know about the size of s at all, many sizes of
        % interval have to be tested for eligibility of golden section search. 
        % The method is to choose (1.5^j)*s
        % for j = -20 to j = 20. If not success, change to the steepest descent method.

        for j = -20:20
            fprintf('using j=%i \n', j) 
            [x1, f1, IFLAG_linesearch, nF_new, nG_new] = golden(@FunctionName, x0, x0 + (1.5^j)*s, e_rel, e_abs, s, itmax);
            nF = nF + nF_new;
            nG = nG + nG_new;
            if IFLAG_linesearch ~= -999
                disp('Newton is success.')
                break
            end
        end

        % If Newton's method is not work, use Steepest Descent.
        if IFLAG_linesearch == -999
            disp('Doing Steepest.')

            % since we don't know about the size of s at all, many sizes of
            % interval have to be tested for eligibility of golden section search. 
            % The method is to choose (1.5^j)*s
            % for j = -20 to j = 200. If not success, we are hopeless.

            s = -gradient0; % search direction.
            for j = -20:200
                fprintf('using j=%i \n', j)
                [x1, f1, IFLAG_linesearch, nF_new, nG_new] = golden(@FunctionName, x0, x0 + (1.5^j)*s, e_rel, e_abs, s, itmax);
                nF = nF + nF_new;
                nG = nG + nG_new;
                if IFLAG_linesearch ~= -999
                    disp('Steepest is success.')
                    break
                end
            end
        end

        if IFLAG_linesearch == -999
            disp("Hopeless."); % hopeless.
            IFLAG = -999;
        end

        Xk(:,i) = x0; % store new x_k.
        Fk(:,i) = f0; % store new f_k.
        Gk(:,i) = gradient0; % store new J_k.

        % For debugging purposes.
        % disp('x1 is: '); fprintf('%.10f \n',x1);
        % disp('x0 is: '); fprintf('%.10f \n',x0);
        % disp('gradient0 is: '); disp(gradient0);

        if norm(x1-x0) < epsilon
            [f1,gradient1,~] = FunctionName(x1, 2); % compute last f and gradient.
            xmin = x1; fmin = f1; % return the outputs.
            Xk(:,i+1) = x1; % store last x value.
            Fk(:,i+1) = f1; % store last f value.
            Gk(:,i+1) = gradient1; % store last gradient value.
            nF = nF + 1;
            nG = nG + 1;
            disp('Finish!')
            break
        end

        x0 = x1; % update a minimum point.
    end

    if i == itmax % to indicate x_k is not converge.
        IFLAG = -999; 
    end
end