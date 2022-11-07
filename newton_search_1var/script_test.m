[xsolution, Xk, Fk, Jk, IFLAG, IterationsUsed] = newton_1var(@FunctionName, 1, 1e-10, 100);

% report the values as a table.
fprintf('% 5s % 20s % 10s \n', 'Iter', 'x_k', 'f_k');
for i = 1:IterationsUsed+1
    fprintf('% 5.2d % 20.10f % 10.3f \n', i, Xk(i), Fk(i));
end
