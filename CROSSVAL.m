function [lambda, Vm, Vs, Tm, Ts] = CROSSVAL(X, Y, perc, nrip, intLambda,iterations)

%intLambda = [0.1, 0.05, 0.02, 0.01, 0.005, 0.002, 0.001, 0.0005, 0.0002, 0.0001]
%[lambda, Vm, Vs, Tm, Ts] = CROSSVAL(xtest, ytest, 0.5, 5, intLambda,10000)
% Output:
% lambda: the value lambda in intLambda that minimize the mean of the
%       validation error
% Vm, Vs: mean and variance of the validation error for each couple of parameters
% Tm, Ts: mean and variance of the error computed on the training set for each couple
%       of parameters

    nLambda = numel(intLambda);
 
    n = size(X,1);
    ntr = ceil(n*(1-perc));
    
    Tm = zeros(1, nLambda);
    Ts = zeros(1, nLambda);
    Vm = zeros(1, nLambda);
    Vs = zeros(1, nLambda);
    
    
    ilambda = 0;
    for lambda=intLambda
        ilambda = ilambda + 1;
        for rip = 1:nrip
            I = randperm(n);
            Xtr = X(I(1:ntr),:);
            Ytr = Y(I(1:ntr),:);
            Xvl = X(I(ntr+1:end),:);
            Yvl = Y(I(ntr+1:end),:);
            
            [fval,w] = PEGASOS2(Xtr, Ytr, lambda,iterations);

            trError =  calcErr(Test(w, Xtr), Ytr);
            Tm(1, ilambda) = Tm(1, ilambda) + trError;
            Ts(1, ilambda) = Ts(1, ilambda) + trError^2;

            valError  = calcErr(Test(w, Xvl), Yvl);
            Vm(1, ilambda) = Vm(1, ilambda) + valError;
            Vs(1, ilambda) = Vs(1, ilambda) + valError^2;

            str = sprintf('lambda\tvalErr\ttrErr\n%f\t%f\t%f\t%f\n', lambda, valError, trError);
            disp(str);
        end
    end
    
    Tm = Tm/nrip;
    Ts = Ts/nrip - Tm.^2;
    
    Vm = Vm/nrip;
    Vs = Vs/nrip - Vm.^2;
    
    idx = find(Vm <= min(Vm(:)));
    
    lambda = intLambda(idx(1));
end

function err = calcErr(T, Y)
   % c1=1-(Y.*T);
   % c1(c1<0)=0;  

    err = sum(T ~= Y)/numel(Y);
    %err = norm(vT -vY)/numel(Y);
   
end