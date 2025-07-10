clear; clc; close all;

load datapiscisla_all

% Vstupy
X = XDataall;

numClasses = 10;
samplesPerClass = size(X, 2) / numClasses;
TDataall = repelem(0:9, samplesPerClass);

% Prevod na one-hot výstupy
T = full(ind2vec(TDataall + 1));  % výstup

% Počet behov pre validáciu
repeats = 5;
accTrain = zeros(1, repeats);
accTest = zeros(1, repeats);
nets = cell(1, repeats);
bestAcc = -inf;

% --- Opakovaný tréning pre rôzne delenie dát ---
for run = 1:repeats
    % Vytvorenie siete
    neurons = 130;
    net = patternnet(neurons);

    % Automatické náhodné rozdelenie dát
    net.divideFcn = 'dividerand';
    net.divideParam.trainRatio = 0.6;
    net.divideParam.valRatio = 0;
    net.divideParam.testRatio = 0.4;

    % Parametre učenia
    net.trainParam.goal = 1e-4;
    net.trainParam.epochs = 300;

    % Trénovanie
    [net, tr] = train(net, X, T);

    % Výstupy siete
    Y = net(X);

    % Indexy po rozdelení
    trainInd = tr.trainInd;
    testInd = tr.testInd;

    % Vyhodnotenie
    [~, predictedTrain] = max(Y(:,trainInd));
    [~, predictedTest] = max(Y(:,testInd));
    [~, trueTrain] = max(T(:,trainInd));
    [~, trueTest] = max(T(:,testInd));

    accTrain(run) = sum(predictedTrain == trueTrain) / length(trueTrain);
    accTest(run) = sum(predictedTest == trueTest) / length(trueTest);

    % Najlepšia sieť
    if accTest(run) > bestAcc
        bestAcc = accTest(run);
        bestNet = net;
        bestTR = tr;
        bestY = Y;
        bestRun = run;
    end
end

% --- Výsledky ---
fprintf('\nVýsledky po %d behoch\n', repeats);
fprintf('Testovacia presnosť: MIN %.2f %% | MAX %.2f %% | PRIEMER %.2f %%\n', ...
    min(accTest)*100, max(accTest)*100, mean(accTest)*100);
fprintf('Trénovacia presnosť: MIN %.2f %% | MAX %.2f %% | PRIEMER %.2f %%\n', ...
    min(accTrain)*100, max(accTrain)*100, mean(accTrain)*100);

% --- Výstupy najlepšej siete ---
fprintf('\nNajlepšia sieť (beh č. %d)\n', bestRun);
figure; plotconfusion(T, bestY, 'Celková konfúzna matica');
figure; plotperform(bestTR);

% --- Testovanie vzoriek ---
fprintf('\nTestovanie vzoriek\n');
sampleIdx = [];
for i = 0:9
    sampleIdx = [sampleIdx, find(TDataall == i, 1)];
end

sampleInput = X(:, sampleIdx);
sampleOutput = bestNet(sampleInput);
[~, predicted] = max(sampleOutput);

for i = 1:length(sampleIdx)
    outputVec = sampleOutput(:, i)';
    fprintf('Vzorka %2d -> Výstup siete: [', i);
    fprintf('%.2f ', outputVec);
    fprintf('] -> Predikcia: %d\n', predicted(i) - 1);
end

fprintf('Skutočné čísla:     %s\n', num2str(TDataall(sampleIdx)));
fprintf('Predikované čísla:  %s\n', num2str(predicted - 1));
fprintf('Správne klasifikovaných: %d z %d\n', ...
    sum(predicted - 1 == TDataall(sampleIdx)), length(sampleIdx));