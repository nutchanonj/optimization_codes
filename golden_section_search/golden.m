function [xmin, fmin, IFLAG, IFunc, Ak, Bk, X1k, X2k] = golden( a, b, epsilon, itmax )
    
    tau = double((sqrt(5)-1)/2);    % golden ratio.
    k = 0;                  % number of iterations.

    x1=a+(1-tau)*(b-a);             % computing x1, x2 values
    x2=a+tau*(b-a);

    f_x1=f(x1);                     % computing f values at x1, x2
    f_x2=f(x2);

    Ak = [];  Ak(1) = a;            % list to store a_k.
    Bk = [];  Bk(1) = b;            % list to store b_k.
    X1k = []; X1k(1) = x1;          % list to store x1_k.
    X2k = []; X2k(1) = x2;          % list to store x2_k.

    if (f(a) > max(f_x2, f_x1) && f(b) > max(f_x2, f_x1))
        disp("This [a,b] interval is good.");

        while ((abs(b-a) > epsilon) && (k < itmax))

            k = k + 1; % new iteration.

            if (f_x1 < f_x2)
                % calculate new values according to the rules...
                b=x2;
                x2=x1;
                x1=a+(1-tau)*(b-a);          
                f_x1=f(x1);
                f_x2=f(x2);
            else
                % calculate new values according to the rules...
                a=x1;
                x1=x2;
                x2=a+tau*(b-a);  
                f_x1=f(x1);
                f_x2=f(x2);
            end

            Ak(k+1) = a;
            Bk(k+1) = b;
            X1k(k+1) = x1;
            X2k(k+1) = x2;
        end

        if (k == itmax)
            disp("too many iterations");
            IFLAG = -999;
        else
            disp("success!");
            IFLAG = 0;
        end

        IFunc = k;
        xmin = (x1+x2)/2;
        fmin = f(xmin);

    else
        disp("This [a,b] interval is not good. Please change the interval.");
        IFLAG = -999;
        xmin = 0; fmin = 0; IFunc = 0;
    end

end
