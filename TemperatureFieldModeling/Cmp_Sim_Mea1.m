function stdErr=Cmp_Sim_Mea(outList,C_,T_sim,T_mea)
    n=size(outList,1);
    stdErrs=zeros(1,n);
    maxErrs=zeros(1,n);
    avgErrs=zeros(1,n);
%     figure;
%     %几种常用的RGB格式的颜色，可选择使用
%     color=[1,0.84314,0;
%            0.80392,0.36078,0.36078;
%            0,0.749021,1;
%            0.82353,0.41176,0.11765;
%            0.6902,0.87843,0.90196;
%            1,0,0;
%            0,1,0;
%            0,0,1;];
%     legends={};
    for i=1:n
        tT_sim=T_sim(:,FindIn(C_,outList{i,1}));
        tT_mea=T_mea(:,outList{i,2}+1);
        err=abs(tT_sim-tT_mea);
        err=err(2000:end);
        stdErrs(i)=sqrt(err'*err/(size(T_mea,1)-1));
        maxErrs(i)=max(err);
        avgErrs(i)=mean(err);
%        t=1:size(T_mea,1);
%         plot(t,tT_sim,'--','Color',color(i,:));
%         hold on;
%         plot(t,tT_mea,'Color',color(i,:));
%         hold on; 
%         lgd_s=[outList{i,1},'_s'];
%         lgd_m=[outList{i,1},'_m'];
%         legends={legends{:,:},lgd_s,lgd_m};
    end
%     legend(legends,'NumColumns',2);
    stdErr=sqrt(stdErrs*stdErrs'/n);
    maxErr=max(maxErrs);
    avgErr=mean(avgErrs);
end