function vsc=VscFcn(vsc40,vsc100,T)
% X=[1,log10(40+273.15);1,log10(100+273.15)];
% B=[log10(vsc40+0.6);log10(vsc100+0.6)];
% K=X\B;
% vsc=[1,log10(T+273.15)]*K;
% vsc=10^vsc-0.6;
beta=-log(vsc100/vsc40)/(100-40);
vsc=vsc40*exp(-beta*(T-40));
end