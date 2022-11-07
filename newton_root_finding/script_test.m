[xsolution, Xk, Fk, Jk, IFLAG, IterationsUsed] = newton(@FunctionName, [8;5], 0.0001, 100);

% report the values as a table.
fprintf('% 5s % 10s % 10s % 10s % 10s \n', 'Iter', 'x1_k', 'x2_k', 'f1_k', 'f2_k');
for i = 1:IterationsUsed+1
    fprintf('% 5.2d % 10.3f % 10.3f % 10.3f % 10.3f \n', i, Xk(1,i), Xk(2,i), Fk(1,i), Fk(2,i));
end
