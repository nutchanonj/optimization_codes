[xmin,fmin,Xk,Fk,Gk,nF,nG,nH,IFLAG] = Newton(@FunctionName,[15;32],1e-5,1e-2,1e-4,1000);

% print out the result.
fprintf('% 5s % 13s % 13s % 15s % 15s % 15s \n', 'Iter', 'x_1', 'x_2', 'f', 'gradient_1', 'gradient_2');
for i = 0:length(Xk)-1
    fprintf('% 5.2d % 13.7f % 13.7f % 15.5f % 15.5f % 15.5f \n', i, Xk(1,i+1), Xk(2,i+1), Fk(i+1), Gk(1,i+1), Gk(2,i+1));
end

fprintf("Number of f calculations:           %i \n", nF)
fprintf("Number of gradient calculations:    %i \n", nG)
fprintf("Number of Hessian calculations:     %i \n", nH)