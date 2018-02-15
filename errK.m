%errore di classicazione cambiando K
function[err,i]= errK(xtrain,ytrain,xtest,ytest,lambda)
klist=[1,20,50,50,100,300,900,1800];
ik = 0;
   
    for k=klist
        ik= ik + 1;
[fval,w] = PEGASOSBATCH(xtrain,ytrain,lambda,k,10000);
 ypred = Test(w, xtest);
 err(ik,1) = sum(ypred ~= ytest)/numel(ytest);
 i(ik,1)=ik;
    end
disp('finish!');
end

 
