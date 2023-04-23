function [legends]=plotSim(outList,C_,T_sim,tTarget)
    n=size(outList,1);
    legends=outList(:,1);
    %几种常用的RGB格式的颜色，可选择使用
    color=[0,0.447,0.741;
           0.850,0.325,0.098;
           0.929,0.694,0.125;
           0.494,0.184,0.556;
           0.466,0.674,0.188;
           0.301,0.745,0.933;
           0.635,0.078,0.184;
           0.5,0.5,0.5];
    for i=1:n
        tT_sim=T_sim(:,FindIn(C_,outList{i,1}));
        t=10:10:size(tT_sim,1);
        tT_sim=mean(reshape(tT_sim,10,600));
        plot(t,tT_sim,'Color',color(i,:),'LineWidth',1);
        hold on;
    end
    xlabel("Time (s)");
    ylabel("Temp. (\circC)");

    speed=tTarget.speed(300);
    xl=xline(0,'--',sprintf('RPM%d',speed));
    xl.LabelVerticalAlignment = 'bottom';
    xl.LabelOrientation = 'horizontal';
    for t=300:tTarget.length
        if tTarget.speed(t)==1000
            xl=xline(t,'--',"RPM1000");
            xl.LabelVerticalAlignment = 'bottom';
            xl.LabelOrientation = 'horizontal';
            break;
        end
    end
    set(gca,'fontsize',12,'fontname','times new roman');
end