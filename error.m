function [err]= error(ypred,y)
err = sum(ypred ~= y)/numel(y);
end
