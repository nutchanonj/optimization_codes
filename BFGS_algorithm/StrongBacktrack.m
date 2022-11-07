function [lambda,nF,nG] = StrongBacktrack(FcnName, x0, s, a, mu, eta)

% -------------- Function inputs --------------
%
% FcnName: function to return the value, the gradient, and the Hessian
% of the particular function.
%   Mode 1: return only f.
%   Mode 2: return f and gradient.
%
% x0: starting point of searching. 
% 
% s: search direction.
%
% a: size of initial lambda.
%
% mu, eta: the parameters used in the stopping criterion for line search.

% -------------- Function outputs --------------
%
% lambda: returned the lambda value that satisfies strong Wolfe's.
%
% nF, nG: numbers of f and gradient calculations.

nF = 0; % number of f calculations.
nG = 0; % number of gradient calculations.

[f0, g0] = FcnName(x0, 2); nF = nF + 1; nG = nG + 1;
% first evaluation of f and gradient.
fprev = f0; aprev = 0; 
% fprev: previous value of f at (x0 + a*s).
% aprev: previous value of a (that is the value going to represent lambda.) 
alo = NaN; ahi = NaN; % the bracket that contain strong Wolfe's. 
% alo represent lower value of f, ahi represent higher value of f.
% However, the value of alo and ahi can be swap without ruining the algorithm.

gr = (sqrt(5) + 1) / 2; % golden ratio.

% finding suitable bracket.
while 1
    [f1, g1] = FcnName(x0 + a*s, 2); nF = nF + 1; nG = nG + 1;
    % evaluate function at (x0 + a*s).
    if f1 > f0 + mu*a*dot(s,g0) || f1 >= fprev
        % If the function value of the right point is more than Armijo's rule or
        % more than that of previous value, 
        % it is sure that the lowest point is there in the bracket, and 
        % there is strong Wolfe's point in that bracket. (Since it is ensured that
        % at aprev, the slope is negative.)
        alo = aprev; ahi = a;
        break
    elseif abs(dot(g1,s)) <= -eta*dot(g0,s)
        % Checking the second strong Wolfe's condition.
        lambda = a;
        return
    elseif dot(g1,s) >= 0
        % If the slope on the right point is positive, it is sure that the 
        % lowest point is there in the bracket, and 
        % there is strong Wolfe's point in that bracket. 
        % (Since it is ensured that at aprev, the slope is negative.)
        alo = aprev; ahi = a;
        break
    end
    % slide the bracket to the right and expand it by multiple of 2.
    fprev = f1; aprev = a; a = 2*a;
end

[flo,~] = FcnName(x0 + alo*s, 1); nF = nF + 1; % f value at (x0 + alo*s).
while 1
    
    % if want to use golden search, use these lines.
    % ----Golden search to find a between alo and ahi.
    % ----f1 is f at (x0 + a*s), g1 is gradient at (x0 + a*s).
    %     c = ahi - (ahi - alo) / gr;
    %     d = alo + (ahi - alo) / gr;
    % 
    %     [fc,gc] = FcnName(x0 + c*s, 2);
    %     [fd,gd] = FcnName(x0 + d*s, 2);
    % 
    %     if fc < fd % f(c) > f(d) to find the maximum.
    %         f1 = fc; g1 = gc; a = c;
    %     else
    %         f1 = fd; g1 = gd; a = d;
    %     end
    % ----end of Golden search

    % if want to use binary search, use this line.
    a = (ahi+alo)/2; [f1,g1] = FcnName(x0 + a*s, 2);
    nF = nF + 1; nG = nG + 1;

    if f1 > f0 + mu*a*dot(s,g0) || f1 > flo
        % if violating Armijo's rule or if f1 still higher than flo, then,
        % set new hi to decrease f at ahi.
        ahi = a;
    else
        if abs(dot(g1,s)) <= -eta*dot(g0,s)
            % Checking the second strong Wolfe's condition.
            lambda = a;
            return
        elseif dot(g1,s)*(ahi - alo) >= 0
            % This condition ensures that ahi and alo always bracket the 
            % lowest point. That is, there is strong Wolfe's point between
            % alo and ahi.
            ahi = alo;
        end
        alo = a;
    end

end

end