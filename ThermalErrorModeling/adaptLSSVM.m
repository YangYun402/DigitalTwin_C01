function ad=adaptLSSVM(gam,sig2,train_x,train_y)
    model= trainlssvm({train_x,train_y,'f',gam,sig2,'RBF_kernel'});
    y=simlssvm(model,train_x);
    ad=sqrt(sum((train_y-y).^2)/length(train_y));
end