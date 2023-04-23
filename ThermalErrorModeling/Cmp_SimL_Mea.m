function [legends]=Cmp_SimL_Mea(outList,C_,T_sim,tTarget)
    outList={'B2';'B1';'O1';'b1';'i1';'s2';'s1'};
    K_L=[-0.144,-0.216,0.072,0.012,0.072,0.12,0.156];
    n=size(outList,1);
    %几种常用的RGB格式的颜色，可选择使用
    color=[0,0.447,0.741;
           0.850,0.325,0.098;
           0.929,0.694,0.125;
           0.494,0.184,0.556;
           0.466,0.674,0.188;
           0.301,0.745,0.933;
           0.635,0.078,0.184;
           0.5,0.5,0.5];
    legends={};
    for i=1:n
        tT_sim(:,i)=T_sim(:,FindIn(C_,outList{i,1}));
    end

    simL=tT_sim*K_L'+(0.2839-4.607e-5*tTarget.speed+6.309E-8*tTarget.speed.^2);
    meaL=tTarget.L(:,1)-tTarget.L(:,2);
    meaL=meaL-meaL(1);
    errs=abs(simL-meaL);
    stdErr=sqrt(mean(errs.^2));

    t=10:10:size(simL,1);
    simL=mean(reshape(simL,10,600));
    meaL=mean(reshape(meaL,10,600));
    plot(t,simL,'--','Color',color(1,:),'LineWidth',1);
    hold on;
    plot(t,meaL,'-','Color',color(2,:),'LineWidth',1);
    legends={'predicted','measured'};
    xlabel("Time (s)");
    ylabel("Elongation (\mum)");

    yyaxis right;
%     t_err=mean(reshape(errs,10,600));
%     plot(t,t_err,'.-','Color',color(3,:),'LineWidth',1);

    speed=tTarget.speed(300);
    xl=xline(0,'--',sprintf('RPM%d',speed));
    xl.LabelVerticalAlignment = 'bottom';
    xl.LabelOrientation = 'horizontal';
    for t=300:tTarget.length
        if tTarget.speed(t)==1000
            xl=xline(t,'--',"RPM1000");
            LL=meaL(floor(t/10)-10)-meaL(floor(t/10)+1);
            xl.LabelVerticalAlignment = 'bottom';
            xl.LabelOrientation = 'horizontal';
            break;
        end
    end
    speed=tTarget.speed(300);
    xl=xline(0,'--',sprintf('RPM%d',speed));
    xl.LabelVerticalAlignment = 'bottom';
    xl.LabelOrientation = 'horizontal';
    for t=300:tTarget.length
        if tTarget.speed(t)==1000
            xl=xline(t,'--',"RPM1000");
            LL=meaL(floor(t/10)-10)-meaL(floor(t/10)+1);
            xl.LabelVerticalAlignment = 'bottom';
            xl.LabelOrientation = 'horizontal';
            break;
        end
    end
    
    ylabel("Residual (\mum)");
    set(gca,'fontsize',12,'fontname','times new roman');
    %ylim([0,4]);

end