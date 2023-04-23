function [X_stable]=getX0(nC,T_t)
    X_stable=ones(1,nC)*mean([T_t{:,2}]);
end