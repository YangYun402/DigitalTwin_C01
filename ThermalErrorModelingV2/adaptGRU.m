function rmse = adaptGRU(X,inputs,outputs)
numHiddenUnits1=X(1)*10;
numHiddenUnits2=X(2)*5;
dropout=X(3)/100;
RMSEs=cell(6,1);
for fold=1:6

    groupTest=[fold,fold+6,fold+12];
    All=1:18;
    groupTrain = All(~ismember(All, groupTest));
    XTrain={};
    YTrain={};
    for i=1:size(groupTrain,2)
        XTrain{i,1}=inputs{groupTrain(i)};
        YTrain{i,1}=outputs{groupTrain(i)};
    end

    numResponses = 1;
    numFeatures = size(XTrain{1,1},1);
%     numHiddenUnits = 200;
%     H0 = zeros(numHiddenUnits,1);
%     C0 = zeros(numHiddenUnits,1);
    mu = mean([XTrain{:}],2);
    sig = std([XTrain{:}],0,2);
    
    for i = 1:numel(XTrain)
        XTrain{i} = (XTrain{i} - mu) ./ sig;
    end
    layers = [ ...
        sequenceInputLayer(numFeatures)
        gruLayer(numHiddenUnits1) %GRU函数 
        %lstmLayer(numHiddenUnits1,'OutputMode','sequence')
        fullyConnectedLayer(numHiddenUnits2)
        dropoutLayer(dropout)%丢弃层概率 
        %reluLayer('name','relu')% 激励函数 RELU 
        fullyConnectedLayer(numResponses)
        regressionLayer];
    maxEpochs = 500;
    miniBatchSize = 100;
    
%     options = trainingOptions('adam', ...
%         'MaxEpochs',maxEpochs, ...
%         'MiniBatchSize',miniBatchSize, ...
%         'InitialLearnRate',0.01, ...
%         'GradientThreshold',1, ...
%         'Shuffle','never', ...
%         'Verbose',0,...
%         'ExecutionEnvironment','auto');
    options = trainingOptions('adam', ... % adam优化算法 自适应学习率 
        'MaxEpochs',maxEpochs,...% 最大迭代次数 
        'MiniBatchSize',miniBatchSize, ...%最小批处理数量 
        'GradientThreshold',1, ...%防止梯度爆炸 
        'InitialLearnRate',0.005, ...% 初始学习率 
        'LearnRateSchedule','piecewise', ...
        'LearnRateDropPeriod',100, ...%125次后 ，学习率下降 
        'LearnRateDropFactor',0.2, ...%下降因子 0.2
        'ExecutionEnvironment','gpu',...
        'Verbose',0);

    net = trainNetwork(XTrain,YTrain,layers,options);

    XTest={};
    YTest={};
    for i=1:size(groupTest,2)
        XTest{i,1}=inputs{groupTest(i)};
        YTest{i,1}=outputs{groupTest(i)};
    end
    for i = 1:numel(XTest)
        XTest{i} = (XTest{i} - mu) ./ sig;
    end
    YTest_Pred = predict(net,XTest,'MiniBatchSize',1);
    
    rmses=zeros(numel(XTest),1);
    for i = 1:numel(YTest)
        rmses(i) = sqrt(mean(mean((YTest_Pred{i}-YTest{i}).^2)));
    end

    %YTest_Preds{fold,dataSource}=YTest_Pred;
    RMSEs{fold}=rmses;
end
results=[RMSEs{:}];
rmse=mean(mean(results));
end