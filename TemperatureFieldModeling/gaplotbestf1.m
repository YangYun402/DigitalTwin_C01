function state = gaplotbestf1(options,state,flag)
switch flag
    case 'init'
        hold on;
        set(gca,'xlim',[0,options.Generations]);
        xlabel('Generation','interp','none');
        ylabel('Fitness value','interp','none');
        plotBest = plot(state.Generation,min(state.Score),'.k');
        set(plotBest,'Tag','gaplotbestf');
    case 'iter'
        best = min(state.Score);
        plotBest = findobj(get(gca,'Children'),'Tag','gaplotbestf');
        newX = [get(plotBest,'Xdata') state.Generation];
        newY = [get(plotBest,'Ydata') best];
        set(plotBest,'Xdata',newX, 'Ydata',newY);
        set(get(gca,'Title'),'String',['Best: ',num2str(best)]);
    case 'done'
        LegnD = legend('Best fitness');
        set(LegnD,'FontSize',8);
        hold off;
end