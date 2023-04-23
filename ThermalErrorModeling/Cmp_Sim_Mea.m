function [stdErr,legends]=Cmp_Sim_Mea(outList,C_,T_sim,tTarget,isPlot)
    T_mea=tTarget.T;
    n=size(outList,1);
    %几种常用的RGB格式的颜色，可选择使用
    color=[%0,0.447,0.741;
           0.850,0.325,0.098;
           0.929,0.694,0.125;
           0.494,0.184,0.556;
           0.466,0.674,0.188;
           0.301,0.745,0.933;
           0.635,0.078,0.184;
           0.5,0.5,0.5];
    legends={};
    errs=zeros(size(T_mea,1),n);
    for i=1:n
        tT_sim=T_sim(:,FindIn(C_,outList{i,1}));
        tT_mea=T_mea(:,outList{i,2}+1);
        errs(:,i)=abs(tT_sim-tT_mea);
        t=10:10:size(T_mea,1);
        tT_sim=mean(reshape(tT_sim,10,600));
        tT_mea=mean(reshape(tT_mea,10,600));
        if isPlot
            plot(t,tT_sim,'--','Color',color(i,:),'LineWidth',1);
            hold on;
            plot(t,tT_mea,':','Color',color(i,:),'LineWidth',1.5);
            hold on; 
            lgd_s=[outList{i,1},'_p'];
            lgd_m=[outList{i,1},'_m'];
            legends={legends{:},lgd_s,lgd_m};
       
        end
    end
    xlabel("Time (s)");
    ylabel("Temp. (\circC)");
    yyaxis right;
    err=sqrt(mean(errs.^2,2));
    t_err=mean(reshape(err,10,600));
    plot(t,t_err,'-','LineWidth',1);
%     legends={legends{:},"RMSE_t"};
    ylabel("tRMS(\circC)");
    stdErr=sqrt(mean(err(600:end).^2))
    set(gca,'fontsize',12,'fontname','times new roman');
    ylim([0,4]);
    %stdErr=max(stdErrs);
    %maxErr=max(maxErrs);
    %avgErr=mean(avgErrs);
    speed=tTarget.speed(300);
    xl=xline(0,'--',"");
    xl.LabelVerticalAlignment = 'bottom';
    xl.LabelOrientation = 'horizontal';
    for t=300:tTarget.length
        if tTarget.speed(t)==1000
            xl=xline(t,'--',"");
            xl.LabelVerticalAlignment = 'bottom';
            xl.LabelOrientation = 'horizontal';
            break;
        end
    end
end