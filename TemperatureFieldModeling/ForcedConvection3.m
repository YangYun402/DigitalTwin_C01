function h=ForcedConvection3(n,K)
    h=K(1)+K(2)*n+K(3)*n^2+K(4)*n^3;
end