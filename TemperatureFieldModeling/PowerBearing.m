function p=PowerBearing(n,T,K)
    vsc=VscFcn(22,K(3),T);
    p=K(1)*n+K(2)*vsc^(2/3)*n^(5/3);
end