function [err,legends]=showS(outList,C_,T_sim,ts,Ts,isPlot)
    n=size(outList,1);
    errs=zeros(n,1);
    %几种常用的RGB格式的颜色，可选择使用
    color=[0,0.447,0.741;
           0.850,0.325,0.098;
           0.929,0.694,0.125;
           0.494,0.184,0.556;
           0.466,0.674,0.188;
           0.301,0.745,0.933;
           0.635,0.078,0.184;
           1,0,0;
           0,1,0;
           0,0,1;];
    legends={};
    t=1:size(T_sim,1);
    for i=1:n
        tT_sim=T_sim(:,FindIn(C_,outList{i,1}));
        errs(i)=tT_sim(ts);
        if isPlot
            plot(t,tT_sim,'--','Color',color(i,:));
            hold on;
            lgd_s=[outList{i,1},'_s'];
            legends={legends{:,:},lgd_s};
        end
    end
    if isPlot==2
        xl=xline(ts,'-.',"Steady Temp.");
        %xl.LabelVerticalAlignment = 'bottom';
        xl.LabelHorizontalAlignment='left';
        %xl.LabelOrientation = 'horizontal';
        errs
%         errs=errs-Ts(6:-1:1)';
%         err=sqrt(errs'*errs/n)
    end
    errs=errs-Ts';
    err=sqrt(mean(errs.^2));
end