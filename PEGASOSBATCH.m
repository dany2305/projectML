function [fval,w] = PEGASOSBATCH(X,Y,lambda,k,iterations)

if(nargin<5 || isempty(iterations)),  iterations = 10000;  end


% intialization

[m,d] = size(X);
w = zeros(d,1);
Tolerance = 10^-6;
t = 1;

if k > m
    k = m;
end

% objective value in each iteration
fval = zeros(iterations, 1);

for t = 1:iterations
       
    % generating indexes uniformly at random without repetitions
    idx = randperm(m);
    idx = idx(1:k);
    A_t = X(idx,:);
    y_t = Y(idx,:);
    
    % indexes with violated samples
    idx = (y_t .* (A_t * w)) < 1;
    eta_t = 1 / (lambda * t);
    
    % update w
    f_dis = A_t(idx,:) .* repmat(y_t(idx,:),1,d);
    w = (1 - 1/t) * w + (eta_t / k) * sum(f_dis, 1)';
    
    % optional operation: project w into a ball
    w = min(1, 1 / (sqrt(lambda) * norm(w))) * w;
    
    % recording objective value with current w
    margin = 1 - (Y .* (X * w));
    idx = margin > 0;
    fval(t) = 0.5 * lambda * w' * w + (1/m) * sum(margin(idx));
end

end