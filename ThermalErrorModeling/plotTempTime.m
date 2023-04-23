function plotTempTime(in)
%in:[time,nodes,RTDs,speed]
ts=in(:,1);
h=figure;
set(h,'visible','off');
sensors={'W1','W2','A0'};
sensor_temp=in(:,[28,30,31]);
axis left;
for i=1:length(sensors)
    plot(ts,sensor_temp(:,i));
    hold on;
end
xlabel('time (s)');
ylabel('temperature (\circC)');
title('Measurement');
axis right;
plot(ts,in(:,end));
ylabel('speed (RPM)');
legend([sensors,{'speed'}],'location','bestoutside');
print(h,'-dbmp','measure.bmp');
%imwrite(frame2im(getframe(gca)),'measure.bmp');

h=figure;

colors=[];
for r=0:0.3:0.9
    for g=0:0.3:0.9
        for b=0:0.3:0.9
            if r+b+g<1.3 && r+b+g> 0.5
                colors=[colors;[r,g,b]];
            end
        end
    end
end
rowrank = [1:7:28,4:7:28,6:7:28,3:7:28,5:7:28,2:7:28,7:7:28];
node_temp=in(:,2:27);
observer={'A1';'A2';'b1';'B1';'B2';'b2';'B3';'B4';'B5';'B6';'C';'H1';'H2';'i1';'i2';'m';'M';'O1';'O2';'R';'s1';'s2';'s3';'s4';'s5';'s6'};
for i=1:length(observer)
    plot(ts,node_temp(:,i),'--','color',colors(rowrank(i),:));
    hold on;
end
legend(observer,'location','bestoutside');
xlabel('time (s)');
ylabel('temperature (\circC)');
title('Temperature prediction');
print(h,'-dbmp','predict.bmp');
end