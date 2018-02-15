 figure;
scatter(xtest(:,1),xtest(:,2),25,ytest);
hold on
sel = (ypred ~= ytest);
scatter(xtest(sel,1),xtest(sel,2),200,ytest(sel),'x'); 
hold off

