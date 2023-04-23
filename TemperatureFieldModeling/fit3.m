clc,clear
x=[0,1,2,3];
%y=[0,0.075,0.086,0.052,0.0024];
y=[0,0.037,0.025,0.037];
figure
scatter(x,y,'k');                                                      %画出原始数据散点图
hold on

duoxiangshi = polyfit(x,y,3); %3次拟合 降幂排列
disp(duoxiangshi);
xi = 0:0.001:4.0;
yi = polyval(duoxiangshi,xi);   %多项式求值
plot(xi,yi);         %观测数据点
hold on

xlabel('x');
ylabel('y');
legend('原始数据','拟合曲线');