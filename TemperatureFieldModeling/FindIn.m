function index=FindIn(X,x)
    n=size(X,1);
    index=0;
    for i=1:n
        if X{i,1}==x
            index=i;
            break;
        end
    end
end