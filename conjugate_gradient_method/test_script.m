%% First, use the Fletcher-Reeves's 
[xmin,fmin,Xk,Fk,Gk,Lk,nF,nG,IFLAG,nReset] = CG(@Rosenbrock,[-1.2;1],5e-9,1e-4,0.1,10000,1);
% print out the result.
disp("Fletcher-Reeves:")
fprintf('% 4s % 10s % 10s % 10s % 10s % 10s % 10s % 3s % 3s % 1s\n', 'Iter', 'x_1', 'x_2', 'f', 'gradient_1', 'gradient_2', 'lambda', 'nF', 'nG', 'nReset');
for i = 1:length(Xk)-1
    fprintf('% 4.i % 10.5f % 10.5f % 10.4f % 10.4f % 10.4f % 10.4f % 3.f % 3.f % 1.f \n', i, Xk(1,i+1), Xk(2,i+1), Fk(i+1), Gk(1,i+1), Gk(2,i+1), Lk(i), nF(i), nG(i), nReset(i));
end

fprintf("Number of f calculations:           %i \n", sum(nF))
fprintf("Number of gradient calculations:    %i \n", sum(nG))
fprintf("Number of resets:                   %i \n", sum(nReset ~= 0))

%% Then, use the Polak-Ribiere's
[xmin,fmin,Xk,Fk,Gk,Lk,nF,nG,IFLAG,nReset] = CG(@Rosenbrock,[-1.2;1],5e-9,1e-4,0.1,10000,2);
% print out the result.
disp("Polak-Ribiere:")
fprintf('% 4s % 10s % 10s % 10s % 10s % 10s % 10s % 3s % 3s % 1s\n', 'Iter', 'x_1', 'x_2', 'f', 'gradient_1', 'gradient_2', 'lambda', 'nF', 'nG', 'nReset');
for i = 1:length(Xk)-1
    fprintf('% 4.i % 10.5f % 10.5f % 10.4f % 10.4f % 10.4f % 10.4f % 3.f % 3.f % 1.f \n', i, Xk(1,i+1), Xk(2,i+1), Fk(i+1), Gk(1,i+1), Gk(2,i+1), Lk(i), nF(i), nG(i), nReset(i));
end

fprintf("Number of f calculations:           %i \n", sum(nF))
fprintf("Number of gradient calculations:    %i \n", sum(nG))
fprintf("Number of resets:                   %i \n", sum(nReset ~= 0))
