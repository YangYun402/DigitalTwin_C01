function Err=sim_All(X,isPlot)
%define X [30*R_+10*Se_+(+1)*5*RPM_+3*N]
%define nX 43+(nTarget+1)*5 
% global BG;
% global targetSelect;
% global targets;
if nargin<2
    isPlot=0;
end
load("initData3.mat");
tBG=BG;
index=0;
sp=[1000;6000;12000;18000];
tp=[100;80;40;20];
% %X->C_
% nC_=size(tBG.C_,1);
% for i=1:nC_
%     tBG.C_{i,2}=10.^X(index+i)*tBG.C_{i,2};
% end
% index=index+nC_;

%X->R_
nR_=size(tBG.R_,1);
for i=1:nR_
    tBG.R_{i,3}=10.^X(index+i)*tBG.R_{i,3};
end
index=index+nR_;

%X->Se_
nSe_=size(tBG.Se_,1);
for i=1:nSe_
    tBG.Se_{i,3}=10.^X(index+i)*tBG.Se_{i,3};
end
index=index+nSe_;

%X->S
for i=1:nR_
    if tBG.R_{i,4}>=1e-6
        index=index+1;
        tBG.R_{i,4}=tBG.R_{i,4}*10.^X(index);
    end
end
for i=1:nSe_
    if tBG.Se_{i,4}>=1e-6
        index=index+1;
        tBG.Se_{i,4}=tBG.Se_{i,4}*10.^X(index);
    end
end

%X->RPM_
% nTarget=size(targetSelect,2);
% tBG.RPM_=zeros(nTarget+1,6);
% tBG.RPM_(1,1)=1000;
% tBG.RPM_(1,2:6)=10.^X((1:5)+index);
% index=index+5;
% for i=1:nTarget
%     tBG.RPM_(i+1,1)=(targetSelect(i)+1)*1000;
%     tBG.RPM_(i+1,2:6)=10.^X((1:5)+index);
%     index=index+5;
% end

% nBearing=size(tBG.K_bearing,1);
% for i=1:nBearing
%     length=size(tBG.K_bearing{i,2},2);
%     tBG.K_bearing{i,2}=X((1:length)+index);
%     if isPlot
%         figure;
%         T=20:20:80;
%         n=1000:1000:20000;
%         for t=T
%             y=n;
%             for j=1:20
%                 y(j)=PowerBearing(n(j),t,tBG.K_bearing{i,2});
%             end
%             plot(n,y);
%             hold on;
%         end
%     end
%     index=index+length;
% end

nBearing=size(tBG.K_bearing,1);
for i=1:nBearing
%     length=9;
%     tBG.K_bearing{i,2}=RegressMap2([1000;10000;20000],[100;60;20],X((1:length)+index)');
    length=16;

    tBG.K_bearing{i,2}=RegressMap3(sp,tp,tBG.K_bearing{i,2}(:).*10.^X((1:length)+index)');
    if isPlot
        subplot(3,1,i+1);
        t=20:10:100;
        n=1000:1000:18000;
        [T,N]=meshgrid(t,n);
        Z=T;
        for j=1:9
            for k=1:18
                Z(k,j)=PowerBearing3(n(k),t(j),tBG.K_bearing{i,2});
            end
        end
        mesh(T,N,Z);
        hold on;
        [T,N]=meshgrid(tp,sp);
        Z=T;
        for j=1:4
            for k=1:4
                Z(k,j)=PowerBearing3(N(k,j),T(k,j),tBG.K_bearing{i,2});
            end
        end
        plot3(T,N,Z,'k*');
        xlabel('Temperature (\circC)');
        ylabel('Speed (RPM)');
        zlabel('Power (W)');
        str=sprintf("map of P_b_%d(n,T)",i);
        legend({str,'fitting data'},'Location','Best');
        
    end
    index=index+length;
end
if isPlot
    subplot(3,1,1);
end
nMotor=size(tBG.K_motor,1);
p={'*','o','s'};
l={'-','--',':'};
for i=1:nMotor
    length=size(tBG.K_motor{i,2},2);
    y=zeros(length,1);
    x=sp;
    dy=tBG.K_motor{i,2}.*10.^X((1:4)+index);
    y(1)=dy(1);
    for j=2:length
        y(j)=y(j-1)+dy(j);
    end
    tBG.K_motor{i,2}=polyfit(x,y,length-1);%3次拟合 降幂排列
    if isPlot
        yyaxis left
        plot(x,y,p{i});
        hold on;
        x=1000:1000:18000;
        y=polyval(tBG.K_motor{i,2},x);
        plot(x,y,l{i});
        xlabel('Speed (RPM)');
        ylabel('Power (W)');
    end
    index=index+4;
end

length=size(tBG.K_h,2);
y=zeros(length,1);
x=sp;
dy=tBG.K_h.*10.^X((1:4)+index);
y(1)=dy(1);
    for j=2:length
        y(j)=y(j-1)+dy(j);
    end
tBG.K_h=polyfit(x,y,length-1);%3次拟合 降幂排列
index=index+4;
if isPlot
    yyaxis right
    plot(x,y,p{3});
    hold on;
    x=1000:1000:18000;
    y=polyval(tBG.K_h,x);
    plot(x,y,l{3});
    xlabel('Speed (RPM)');
    ylabel('Convection coefficient (W/m^2/\circC)');
    legend({'fitting data','curve of P_M(n)','fitting data','curve of P_m(n)','fitting data','curve of h_F(n)'},'Location','Best');
end

%X->N
tBG.N=tBG.N.*10.^X((index+1):end);
if isPlot
    figure;
    %targetSelect=[1:4,6:10,12:16,18];
    %targetSelect=[5,11,17];
else
    targetSelect=[2,5,8,11,14,17];
end
nTarget=size(targetSelect,2);
Errs=zeros(1,nTarget);
for iTarget=1:nTarget
    if isPlot
        subplot(6,3,iTarget);
        [Errs(iTarget),~,legends]=sim_T(tBG,targets(targetSelect(iTarget)),1);
        title("validating #"+iTarget+" (set #"+targetSelect(iTarget)+")");
        ylim([0,5]);
       % set(gca,"outerposition",[0,0.9-iTarget*0.3,1,0.3]);
    else
        [Errs(iTarget),~,~]=sim_T(tBG,targets(targetSelect(iTarget)),isPlot);
    end
end
Err=sqrt(Errs*Errs'/nTarget);
%Err=max(Errs);
if isPlot
    
    legend(legends,'numcolumns',7);
    Errs
    Err
end
% 
% if isPlot==2
%     figure;
%     targetSelect=[2,5,8,11,14,17];
%     nTarget=size(targetSelect,2);
%     for iTarget=1:nTarget
%         subplot(nTarget,1,iTarget);
%         [~,~,legends]=sim_T(tBG,targets(targetSelect(iTarget)),isPlot);
%         title(['set ',num2str(targetSelect(iTarget))], 'Fontsize', 10);
%         ylabel('Temp. (\circC)', 'Fontsize', 10);
%         
%     end   
%     xlabel('time (s)', 'Fontsize', 10);
%     legend(legends, 'Fontsize', 9);
% end

end