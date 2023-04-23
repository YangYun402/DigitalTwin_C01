function [stdErr,legends]=Cmp_Sim_Mea(outList,C_,T_sim,T_mea,isPlot)
    n=size(outList,1);
    %几种常用的RGB格式的颜色，可选择使用
    color=[0,0.447,0.741;
           0.850,0.325,0.098;
           0.929,0.694,0.125;
           0.494,0.184,0.556;
           0.466,0.674,0.188;
           0.301,0.745,0.933;
           0.635,0.078,0.184];
    legends={};
    errs=zeros(size(T_mea,1),n);
    for i=1:n
        tT_sim=T_sim(:,FindIn(C_,outList{i,1}));
        tT_mea=T_mea(:,outList{i,2}+1);
        errs(:,i)=abs(tT_sim-tT_mea);
        t=1:size(T_mea,1);
        if isPlot
            plot(t,tT_sim,'--','Color',color(i,:));
            hold on;
            plot(t,tT_mea,'-.','Color',color(i,:));
            hold on; 
            lgd_s=[outList{i,1},'_p'];
            lgd_m=[outList{i,1},'_m'];
            legends={legends{:},lgd_s,lgd_m};
        end
    end
    err=sqrt(mean(errs.^2,2));
    stdErr=sqrt(mean(err.^2));
    if isPlot
        xlabel("Time (s)");
        ylabel("Temperature (\circC)");
        yyaxis right;
        plot(t,err,'-');
        %legends={legends{:},"RMSE_t"};
        ylabel("Transient RMSE(\circC)");
        
        set(gca,'fontsize',12,"fontname","times new roman");
    end
    %stdErr=max(stdErrs);
    %maxErr=max(maxErrs);
    %avgErr=mean(avgErrs);
end