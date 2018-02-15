function [fval,w] = PEGASOS2(x,y,lambda,iterations)
[m,d] = size(x);
w = zeros(d,1);
Tolerance = 10^-6;
t = 1;
if(nargin<4 || isempty(iterations)),    iterations = 10000;  end
% objective value in each iteration
fval = zeros(iterations, 1);
% iterations over the full data
for t = 1:iterations 
    % generating index uniformly at random
    idx = randperm(m);
    idx = idx(1);   % pick a single data point
    eta_t = 1 / (lambda * t);
        if (y(idx)*x(idx,:)*w < 1)  
            w_old = w;
            w = (1-1/t)*w + eta_t*y(idx)*x(idx,:)';
        else
            w_old = w;
            w = (1-1/t)*w;
        end
        w = min(1, 1 / (sqrt(lambda) * norm(w))) * w;   % optional operation: project w into a ball
        if(norm(w-w_old) < Tolerance)
        break;
        end
      % recording objective value with current w
    margin = 1 - (y(idx,:)*(x(idx,:)*w));
    margin = max(0,margin);
    fval(t,1) = 0.5 * lambda * w'*w + margin;
end
    if(t<iterations)
    fprintf('\nW converged in %d iterations.',t);
    end
    c1=1-(y.*(x*w));
    c1(c1<0)=0;  
    cost = w'*w+ lambda*(sum(c1));
    fprintf('Cost:%f\n',cost);
end     