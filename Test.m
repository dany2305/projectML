function [ypred] = Test(w, Xts)
    ypred = sign(Xts*w);
end
