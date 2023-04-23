function K=RegressMap2(x1,x2,dy)
    dY=[dy(1:3) dy(4:6) dy(7:9)];
    Y=zeros(3,3);
    Y(1,1)=dY(1,1);
    for i=1:2
        Y(i+1,1)=dY(i+1,1)+Y(i,1);
    end
    for j=1:2
        Y(1,j+1)=dY(1,j+1)+Y(1,j);
    end
    for i=1:2
        for j=1:2
            Y(i+1,j+1)=dY(i+1,j+1)+max(Y(i,j+1),Y(i+1,j));
        end
    end
    [X1,X2]=meshgrid(x1,x2);
    x1=X1(:);
    x2=X2(:);
    y=Y(:);
    X=[x1.^2 x2.^2 x1.*x2 x1 x2 ones(9,1)];
    K=regress(y,X);
%     y_=X*K;
%     figure;
%     Y_=[y_(1:4) y_(5:8) y_(9:12) y_(13:16)];
%     mesh(X1,X2,Y_)
%     hold on;
%     plot3(x1,x2,y,'*');
end