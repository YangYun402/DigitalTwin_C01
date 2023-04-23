function plotTempField(Temp,node_name,speed)
subnode.s1=[...
    zeros(8,1),(5:12)';
    ones(5,1),(5:9)';
    ones(5,1)*2,(5:9)';
    ones(5,1)*3,(5:9)';
    ones(5,1)*4,(5:9)'];
subnode.s2=[...
    (8:20)',ones(13,1)*4;
    (5:20)',ones(16,1)*5;
    (5:20)',ones(16,1)*6;
    (5:20)',ones(16,1)*7;
    (5:20)',ones(16,1)*8;
    (11:14)',ones(4,1)*9];
subnode.s3=[...
    ones(7,1)*21,(4:10)';
    ones(7,1)*22,(4:10)';
    ones(7,1)*23,(4:10)';
    ones(7,1)*24,(2:8)';
    ones(7,1)*25,(2:8)';
    ones(7,1)*26,(2:8)';
    ones(7,1)*27,(2:8)';
    ones(7,1)*28,(2:8)'];
subnode.s4=[...
    (29:50)',ones(22,1)*3;
    (29:73)',ones(45,1)*4;
    (29:73)',ones(45,1)*5;
    (29:73)',ones(45,1)*6];
subnode.s5=[...
    (74:90)',ones(17,1)*4;
    (74:90)',ones(17,1)*5;
    (74:90)',ones(17,1)*6;
    [81:83,88:90]',ones(6,1)*7];
subnode.s6=[...
    (89:99)',ones(11,1)*3;
    ones(4,1)*91,(4:7)';
    ones(4,1)*92,(4:7)'];
subnode.i1=[...
    (5:10)',ones(6,1)*9;
    (15:20)',ones(6,1)*9];
subnode.i2=[...
    (84:87)',ones(4,1)*7];
subnode.M=[...
    (26:78)',ones(53,1)*11;
    (26:78)',ones(53,1)*12;
    (26:78)',ones(53,1)*13;
    (26:78)',ones(53,1)*14;
    (30:70)',ones(41,1)*15];
subnode.m=[...
    (29:73)',ones(45,1)*7;
    (29:73)',ones(45,1)*8;
    (29:73)',ones(45,1)*9];
subnode.b1=[...
    [6:9,16:19]',ones(8,1)*10;
    [6:9,16:19]',ones(8,1)*11;
    [6:9,16:19]',ones(8,1)*12];
subnode.b2=[...
    [85,86]',[8,8]';
    [85,86]',[9,9]'];
subnode.O1=[...
    (5:10)',ones(6,1)*13;
    (15:20)',ones(6,1)*13];
subnode.O2=[...
    (84:89)',ones(6,1)*10];
subnode.W1=[...
    (11:14)',ones(4,1)*11;
    (11:14)',ones(4,1)*12;
    ones(4,1)*21,(12:15)';
    ones(4,1)*22,(12:15)';
    ones(4,1)*23,(12:15)'];
subnode.W2=[...
    (30:81)',ones(52,1)*18];
subnode.H1=[...
    (19:82)',ones(64,1)*16;
    (19:82)',ones(64,1)*17;
    (19:29)',ones(11,1)*18;
    82,18];
subnode.H2=[...
    (83:92)',ones(10,1)*16;
    (83:92)',ones(10,1)*17;
    (83:92)',ones(10,1)*18];
subnode.B1=[...
    (5:9)',ones(5,1)*14;
    (5:9)',ones(5,1)*15];
subnode.B2=[...
    ones(4,1)*2,(11:14)';
    ones(4,1)*3,(11:14)';
    ones(4,1)*4,(11:14)'];
subnode.B3=[...
    (10:14)',ones(5,1)*15;
    (10:14)',ones(5,1)*16];
subnode.B4=[...
    (11:14)',ones(4,1)*13;
    (10:14)',ones(5,1)*14];
subnode.B5=[...
    (14:18)',ones(5,1)*17;
    (14:18)',ones(5,1)*18;
    (14:18)',ones(5,1)*19;
    (14:18)',ones(5,1)*20;
    (14:18)',ones(5,1)*21];
subnode.B6=[...
    (15:20)',ones(6,1)*14;
    (15:20)',ones(6,1)*15;
    (15:18)',ones(4,1)*16];
subnode.R=[...
    (81:83)',ones(3,1)*9;
    (81:83)',ones(3,1)*10;
    (81:89)',ones(9,1)*11;
    (81:89)',ones(9,1)*12;
    (81:89)',ones(9,1)*13;
    (82:89)',ones(8,1)*14;
    (83:89)',ones(7,1)*15];
subnode.C=[...
    ones(7,1)*91,(9:15)';
    ones(7,1)*92,(9:15)';
    ones(10,1)*93,(9:18)';
    ones(10,1)*94,(9:18)';
    ones(10,1)*95,(9:18)'];
node = fieldnames(subnode);

strongnode.s1=[...
    zeros(6,1),(7:12)';
    (8:15)',ones(8,1)*4];
strongnode.s2=[...
    (26:30)',ones(5,1)*6];
strongnode.s3=[...
    (37:42)',ones(6,1)*6];
strongnode.s4=[...
    (50:55)',ones(6,1)*6];
strongnode.s5=[...
    (67:72)',ones(6,1)*6];
strongnode.s6=[...
    (88:90)',ones(3,1)*6];
strongnode.i1=[...
    (5:10)',ones(6,1)*9;
    (15:20)',ones(6,1)*9];
strongnode.i2=[...
    (84:87)',ones(4,1)*7];
strongnode.M=[...
    (31:70)',ones(40,1)*12];
strongnode.m=[...
    (50:55)',ones(6,1)*9];
strongnode.b1=[...
    [6:9,16:19]',ones(8,1)*10;
    [6:9,16:19]',ones(8,1)*11;
    [6:9,16:19]',ones(8,1)*12];
strongnode.b2=[...
    [85,86]',[8,8]';
    [85,86]',[9,9]'];
strongnode.O1=[...
    (5:10)',ones(6,1)*13;
    (15:20)',ones(6,1)*13];
strongnode.O2=[...
    (84:87)',ones(4,1)*10];
strongnode.W1=[...
    (11:14)',ones(4,1)*11;
    (11:14)',ones(4,1)*12;
    ones(4,1)*21,(12:15)';
    ones(4,1)*22,(12:15)';
    ones(4,1)*23,(12:15)'];
strongnode.W2=[...
    (30:81)',ones(52,1)*18];
strongnode.H1=[...
    (31:70)',ones(40,1)*16];
strongnode.H2=[...
    (85:90)',ones(6,1)*18];
strongnode.B1=[...
    (6:8)',ones(3,1)*15];
strongnode.B2=[...
    ones(4,1)*2,(11:14)'];
strongnode.B3=[...
    (11:13)',ones(3,1)*16];
strongnode.B4=[...
    (11:13)',ones(3,1)*14];
strongnode.B5=[...
    (14:18)',ones(5,1)*21];
strongnode.B6=[...
    (16:17)',ones(2,1)*16];
strongnode.R=[...
    (83:87)',ones(5,1)*12];
strongnode.C=[...
    ones(6,1)*95,(11:16)'];
strongnodes=zeros(43,100);
x=0:99;
y=-21:21;
z=NaN(43,100);
for i= 1:length(node)
    for j=1:size(subnode.(node{i}),1)
        z(22-subnode.(node{i})(j,2),subnode.(node{i})(j,1)+1)=22;
        z(subnode.(node{i})(j,2)+22,subnode.(node{i})(j,1)+1)=22;
    end
end



for i= 1:length(node)
    index=FindIn(node_name,node{i});
    for j=1:size(strongnode.(node{i}),1)
        strongnodes(22-strongnode.(node{i})(j,2),strongnode.(node{i})(j,1)+1)=1;
        strongnodes(strongnode.(node{i})(j,2)+22,strongnode.(node{i})(j,1)+1)=1;
        z(22-strongnode.(node{i})(j,2),strongnode.(node{i})(j,1)+1)=Temp(index);
        z(strongnode.(node{i})(j,2)+22,strongnode.(node{i})(j,1)+1)=Temp(index);
    end
end

v=0.3;
h=0.3;
for loop=1:200
    for i=1:43
        for j=1:100
            if ~isnan(z(i,j)) && ~strongnodes(i,j)
                n=1;
                T=z(i,j);
                if i>1 && ~isnan(z(i-1,j))
                    n=n+v;
                    T=T+z(i-1,j)*v;
                end
                if i<43 && ~isnan(z(i+1,j))
                    n=n+v;
                    T=T+z(i+1,j)*v;
                end
                if j>1 && ~isnan(z(i,j-1))
                    n=n+h;
                    T=T+z(i,j-1)*h;
                end
                if j<100 && ~isnan(z(i,j+1))
                    n=n+h;
                    T=T+z(i,j+1)*h;
                end
                if i>1 && j>1 && ~isnan(z(i-1,j-1))
                    n=n+v*h;
                    T=T+z(i-1,j-1)*v*h;
                end
                if i>1 && j<100 && ~isnan(z(i-1,j+1))
                    n=n+v*h;
                    T=T+z(i-1,j+1)*v*h;
                end
                if i<43 && j>1 && ~isnan(z(i+1,j-1))
                    n=n+v*h;
                    T=T+z(i+1,j-1)*v*h;
                end
                if i<43 && j<100 && ~isnan(z(i+1,j+1))
                    n=n+v*h;
                    T=T+z(i+1,j+1)*v*h;
                end
                z(i,j)=T/n;
            end
        end
    end
end
h=figure('color','w');
%set(h,'visible','off');
c=pcolor(x,y,z);
set(c,'LineStyle','none');
set(gca,'CLim',[20,100]);
axis equal;
axis off;
colormap("jet");
b=colorbar;
set(b, 'location','south','Limits',[20,100],"fontname","times new roman","fontsize",20);
imwrite(frame2im(getframe(h)),"S"+speed+".bmp");
center=zeros(1,100);
for i=1:100
    for j=22:43
        if ~isnan(z(j,i))
            center(i)=z(j,i);
            break;
        end
    end
end
csvwrite("S"+speed+".csv",center);
end