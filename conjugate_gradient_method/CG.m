function  [xmin,fmin,Xk,Fk,Gk,Lk,nF,nG,IFLAG,nReset] = CG(FcnName,x0,epsilon,mu,eta,itmax,option)

% -------------- Function inputs --------------
%
% FcnName: function to return the value, the gradient, and the Hessian
% of the particular function.
%   Mode 1: return only f.
%   Mode 2: return f and gradient.
%
% x0: starting point of searching.
%
% epsilon: stoping criterion of the minimum search. (norm(x1-x0) < epsilon.)
%
% mu, eta: the parameters used in the stopping criterion for line search.
%
% itmax: max allowed number of iterations. 
% 
% option: 1 = Fletcher-Reeves, 2 = Polak-Ribiere.

% -------------- Function outputs --------------
%
% xmin, fmin: returned minimum function argument and value, respectively.
%
% Xk ,Fk, Gk, Lk: arrays to keep x, f, gradient and lambda along the search steps.
%
% nF, nG: numbers of f and gradient calculations in each iteration.
%
% IFLAG: indicate the success. 0 if success, -999 otherwise.
%
% nReset: reset condition in each iteration 
% 0 = no reset, 1 = reset because too large angle between s and -g
% 2 = reset because s does not have a descent property. 

Xk = []; % list to store x_k.
Fk = []; % list to store f_k.
Gk = []; % list to store g_k.
Lk = []; % list to store l_k.

nF_val = 0; % number of f calculations in each iteration.
nG_val = 0; % number of gradient calculations in each iteration.

nF = []; % array to store nF_val of each iteration.
nG = []; % array to store nG_val of each iteration.
nReset = []; % array to store reset condition of each iteration.

IFLAG = -999; % IFLAG: indicate the success.

[f0, g0] = FcnName(x0, 2); nF_val = nF_val + 1; nG_val = nG_val + 1;
s = -g0; % set first line search direction.

for i = 1:itmax

    % strong backtracking.
    a = 1; % first value of lambda.
    [lambda,nFnew,nGnew] = StrongBacktrack(FcnName, x0, s, a, mu, eta);
    % finding lambda that satisfied strong Wolfe's.
    nF_val = nF_val + nFnew; nG_val = nG_val + nGnew;

    % update values.
    x1 = x0 + lambda*s;
    [f1,g1] = FcnName(x1, 2); nF_val = nF_val + 1; nG_val = nG_val + 1;
    if option == 1
        beta = norm(g1)/norm(g0); % Fletcher-Reeves
    elseif option == 2
        beta = dot(g1,g1-g0)/norm(g0); % Polak-Ribiere
    else
        disp('invalid option.');
        break
    end
    s = -g1 + beta*s; % new line search direction.
    
    % Reset if angle between s and g1 is too large (> 85 degree.)
    cos_angle = dot(s,-g1)/(norm(s)*norm(-g1));
    if cos_angle < cosd(85) && cos_angle > 0
        s = -g1; nReset(i) = 1; % the angle is too large.
    elseif cos_angle <= 0 
        s = -g1; nReset(i) = 2; % s does not have a descent property.
    else
        nReset(i) = 0; % no reset.
    end

    % store values.
    Xk(:,i) = x0; Fk(i) = f0; Gk(:,i) = g0; Lk(i) = lambda;
    nF(i) = nF_val; nG(i) = nG_val;

    % terminate
    if norm(x1-x0) < epsilon % at local minimum, gradient converges to 0.
        xmin = x1; fmin = f1; IFLAG = 0;
        disp('search successful.');
        break
    end

    % update values.
    x0 = x1; f0 = f1; g0 = g1; nF_val = 0; nG_val = 0;
end

if IFLAG == -999
    xmin = 0; fmin = 0; disp('search unsuccessful.');
end

end