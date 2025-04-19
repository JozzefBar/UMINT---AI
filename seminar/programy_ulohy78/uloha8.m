clear; clc; close all;

% === Načítanie dát ===
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

% === Definícia dvoch CNN štruktúr ===
layers1 = [
    imageInputLayer([28 28 1])
    convolution2dLayer(3, 8, 'Padding', 'same')
    batchNormalizationLayer
    reluLayer
    maxPooling2dLayer(2, 'Stride', 2)
    fullyConnectedLayer(10)
    softmaxLayer
    classificationLayer];

layers2 = [
    imageInputLayer([28 28 1])
    convolution2dLayer(3, 16, 'Padding', 'same')
    batchNormalizationLayer
    reluLayer
    convolution2dLayer(3, 32, 'Padding', 'same')
    batchNormalizationLayer
    reluLayer
    maxPooling2dLayer(2, 'Stride', 2)
    fullyConnectedLayer(64)
    reluLayer
    fullyConnectedLayer(10)
    softmaxLayer
    classificationLayer];

% === Parametre učenia ===
options = trainingOptions('adam', ...
    'MaxEpochs', 12, ...
    'MiniBatchSize', 64, ...
    'InitialLearnRate', 1e-3, ...
    'Shuffle', 'every-epoch', ...
    'Verbose', false);

% === Opakovanie tréningu ===
repeats = 5;
acc1_all = zeros(1, repeats);
acc2_all = zeros(1, repeats);
maxAcc = -inf;

for run = 1:repeats
    fprintf('\n=== Beh č. %d ===\n', run);

    % Náhodné rozdelenie dát 60/40
    idx = randperm(N);
    idxTrain = idx(1:round(0.6*N));
    idxTest = idx(round(0.6*N)+1:end);

    XTrain = Ximgs(:, :, :, idxTrain);
    TTrain = T(idxTrain);
    XTest = Ximgs(:, :, :, idxTest);
    TTest = T(idxTest);

    % Tréning CNN1
    fprintf('\n--- CNN Štruktúra 1 ---\n');
    net1 = trainNetwork(XTrain, TTrain, layers1, options);
    YPred1 = classify(net1, XTest);
    acc1 = sum(YPred1 == TTest) / numel(TTest);
    acc1_all(run) = acc1;
    fprintf('Presnosť CNN1: %.2f %%\n', acc1 * 100);

    % Tréning CNN2
    fprintf('\n--- CNN Štruktúra 2 ---\n');
    net2 = trainNetwork(XTrain, TTrain, layers2, options);
    YPred2 = classify(net2, XTest);
    acc2 = sum(YPred2 == TTest) / numel(TTest);
    acc2_all(run) = acc2;
    fprintf('Presnosť CNN2: %.2f %%\n', acc2 * 100);

    % Uloženie najlepšej siete CNN2
    if acc2 > maxAcc
        maxAcc = acc2;
        bestNet = net2;
        bestYPred = YPred2;
        bestTTest = TTest;
        bestRun = run;
    end
end

% === Výsledky ===
fprintf('\n=== Výsledky po %d behoch ===\n', repeats);
fprintf('CNN1 presnosť: MIN %.2f %% | MAX %.2f %% | PRIEMER %.2f %%\n', ...
    min(acc1_all)*100, max(acc1_all)*100, mean(acc1_all)*100);
fprintf('CNN2 presnosť: MIN %.2f %% | MAX %.2f %% | PRIEMER %.2f %%\n', ...
    min(acc2_all)*100, max(acc2_all)*100, mean(acc2_all)*100);

% === Porovnanie s MLP (z úlohy 7) ===
mlp_accuracy = 98.00;  % <- dopíš tvoju skutočnú hodnotu
fprintf('\n--- Porovnanie s MLP ---\n');
fprintf('MLP presnosť:  %.2f %%\n', mlp_accuracy);
fprintf('CNN2 presnosť: %.2f %% (najlepšia CNN)\n', maxAcc * 100);
fprintf('Táto sieť bola natrénovaná v behu č. %d\n', bestRun);

% === Confusion matica pre najlepší beh ===
fprintf('\n--- Confusion matica najlepšej CNN siete ---\n');
figure; plotconfusion(bestTTest, bestYPred, 'Najlepšia CNN2');

% === Testovanie vzoriek ===
fprintf('\n--- Testovanie vzoriek ---\n');
figure;
for i = 0:9
    idxClass = find(TDataall == i, 1, 'first');
    img = Ximgs(:, :, 1, idxClass);
    label = TDataall(idxClass);
    pred = classify(bestNet, img);

    subplot(2,5,i+1);
    imshow(permute(img, [2 1 3]));  % správna orientácia
    title(sprintf('Skutočné: %d\nPredikcia: %s', label, string(pred)));
end