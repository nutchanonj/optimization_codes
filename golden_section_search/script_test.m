a = 0;
b = 0.05;
epsilon = 1e-10;
itmax = 100;
IFLAG = -999;

while (IFLAG == -999) % iterates until find the suitable b.
    [xmin, fmin, IFLAG, IFunc, Ak, Bk, X1k, X2k] = golden( a, b, epsilon, itmax );
    b = b + 0.05; % increment b until the interval contains minimizer.
end

% print out the result.
fprintf('% 5s % 20s % 20s % 20s % 20s \n', 'Iter', 'a', 'x_1', 'x_2', 'b');
for i = 0:IFunc
    fprintf('% 5.2d % 20.10f % 20.10f % 20.10f % 20.10f \n', i, Ak(i+1), X1k(i+1), X2k(i+1), Bk(i+1));
end



