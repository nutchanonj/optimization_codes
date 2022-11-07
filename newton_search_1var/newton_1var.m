function [xsolution, Xk, Fk, Jk, IFLAG, IterationsUsed] = newton_1var(FunctionName, x0, epsilon, IterationMax)

    Xk = x0; % list to store x_k.
    Fk = []; % list to store f_k.
    Jk = []; % list to store J_k.
    IFLAG = 0; % Flag to indicate whether x_k converge.

    for i = 1:IterationMax
        [f, J] = FunctionName(x0); % generate f and J matrix at x0.
        s = J\(-f); % solve for step value s.
        x1 = x0 + s; % find next x_k.
        
        Xk(:,i+1) = x1; % store new x_k.
        Fk(:,i) = f; % store new f_k.
        Jk(:,:,i) = J; % store new J_k.

        if norm(x1-x0) <= epsilon % stop if the step is small enough.
            IterationsUsed = i; % return a number of iterations.
            xsolution = x1; % return the root of function.
            [f, J] = FunctionName(x1); % finding new f, J final value.
            Fk(:,i+1) = f; % store last f_k.
            Jk(:,:,i+1) = J; % store last J_k.
            break
        end

        x0 = x1; % set next x_k to be x_(k+1).
    end
    
    if IterationsUsed == IterationMax % to indicate x_k is not converge.
        IFLAG = 1;
    end

end