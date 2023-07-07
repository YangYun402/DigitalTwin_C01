function ad=adaptLSSVM(gam,sig2,train_x,train_y,test_x,test_y)
    model= trainlssvm({train_x,train_y,'f',gam,sig2,'RBF_kernel'});
    y=simlssvm(model,test_x);
    ad=sqrt(sum((test_y-y).^2)/length(test_y));
end