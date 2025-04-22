clear; clc; close all;

%Načítanie dát
load datapiscisla_all
X = XDataall;
numClasses = 10;
samplesPerClass = size(X, 2) / numClasses;

% Vytvorenie tried
TDataall = repelem(0:9, samplesPerClass);
T = categorical(TDataall)';

% Prevod na obrázky 28x28x1 (pre CNN vstup)
N = size(X, 2);
Ximgs = reshape(X, 28, 28, 1, N);  % 4D: 28x28x1xN

%Definícia CNN štruktúry
layers = [
    imageInputLayer([28 28 1])                           % vstupná vrstva – obraz 28x28x1
    convolution2dLayer(5, 6)                             % 2D konvolúcia – 6 filtrov, rozmer 5x5
    batchNormalizationLayer                              % dávková normalizácia
    reluLayer()                                          % ReLU funkcia

    convolution2dLayer(5, 12)                            % 2D konvolúcia – 12 filtrov, rozmer 5x5
    batchNormalizationLayer                              % dávková normalizácia
    reluLayer()                                          % ReLU funkcia
    maxPooling2dLayer(2, 'Stride', 2)                    % max pooling – 2x2, krok 2
    fullyConnectedLayer(32)                              % plne prepojená vrstva – 32 neurónov
    dropoutLayer(0.5)                                    % dropout vrstva
    fullyConnectedLayer(10)                              % plne prepojená vrstva – 10 neurónov
    softmaxLayer()                                       % softmax aktivačná funkcia
    classificationLayer()                                % klasifikačná vrstva – 10 tried
];

%Tréning s opakovaním
repeats = 5;
acc_all = zeros(1, repeats);
maxAcc = -inf;

for run = 1:repeats
    fprintf('\nBeh č. %d\n', run);

    idx = randperm(N);
    idxTrain = idx(1:round(0.6*N));
    idxTest  = idx(round(0.6*N)+1:end);

    XTrain = Ximgs(:, :, :, idxTrain);
    TTrain = T(idxTrain);
    XTest = Ximgs(:, :, :, idxTest);
    TTest = T(idxTest);

    options = trainingOptions('sgdm', ...               %Stochastic Gradient Descent with Momentum
        'MaxEpochs', 20, ...
        'InitialLearnRate', 1e-2, ...
        'MiniBatchSize', 256, ...
        'Shuffle', 'once', ...
        'ExecutionEnvironment', 'auto', ...
        'Plots','training-progress');

    net = trainNetwork(XTrain, TTrain, layers, options);

    YPredTest = classify(net, XTest);
    acc = sum(YPredTest == TTest) / numel(TTest);
    acc_all(run) = acc;
    fprintf('Presnosť: %.2f %%\n', acc * 100);

    if acc > maxAcc
        maxAcc = acc;
        bestNet = net;
        bestYPredTest = YPredTest;
        bestTTest = TTest;
        bestYPredTrain = classify(net, XTrain);
        bestTTrain = TTrain;
        bestYPredAll = classify(net, Ximgs);
        bestTAll = T;
        bestRun = run;
    end
end

%Výsledky
fprintf('\n=== Výsledky po %d behoch ===\n', repeats);
fprintf('Presnosť: MIN %.2f %% | MAX %.2f %% | PRIEMER %.2f %%\n', ...
    min(acc_all)*100, max(acc_all)*100, mean(acc_all)*100);
fprintf('Najlepšia sieť bola natrénovaná v behu č. %d\n', bestRun);

%Confusion matice
figure; plotconfusion(bestTTrain, bestYPredTrain, 'Trénovacie dáta');
figure; plotconfusion(bestTTest, bestYPredTest, 'Testovacie dáta');
figure; plotconfusion(bestTAll, bestYPredAll, 'Celkové dáta');

% Testovanie vzoriek
fprintf('\n--- Testovanie vzoriek ---\n');
figure;
for i = 0:9
    idxClass = find(TDataall == i, 1, 'first');
    img = Ximgs(:, :, 1, idxClass);
    label = TDataall(idxClass);
    pred = classify(bestNet, img);

    subplot(2,5,i+1);
    imshow(permute(img, [2 1 3]));
    title(sprintf('Skutočné: %d\nPredikcia: %s', label, string(pred)));
end