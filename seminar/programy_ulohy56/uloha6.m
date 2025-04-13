close all; clear; clc;

% ===== PARAMETRE SIETE =====
params.hiddenNeurons = 50;
params.epochs = 200;
params.goal = 1e-2;
params.validationRepeats = 5;
params.gui = false;

% ===== NAČÍTANIE A PRÍPRAVA DÁT =====
load CTGdata
inputData = NDATA';
targetLabels = typ_ochorenia(:)';
targetOneHot = full(ind2vec(targetLabels));

% Indexy podľa tried
idx1 = find(targetLabels == 1);
idx2 = find(targetLabels == 2);
idx3 = find(targetLabels == 3);
idx1 = idx1(randperm(length(idx1)));
idx2 = idx2(randperm(length(idx2)));
idx3 = idx3(randperm(length(idx3)));

% Blokové rozdelenie
blocks = 50;
blockIndices = [];

for i = 1:blocks
    r1 = (1 + floor(length(idx1)/blocks)*(i-1)):(floor(length(idx1)/blocks)*i);
    r2 = (1 + floor(length(idx2)/blocks)*(i-1)):(floor(length(idx2)/blocks)*i);
    r3 = (1 + floor(length(idx3)/blocks)*(i-1)):(floor(length(idx3)/blocks)*i);
    blockIndices(i, :) = [idx1(r1), idx2(r2), idx3(r3)];
end

% ===== VÝPOČTY =====
confTr = zeros(1, params.validationRepeats);
confTs = zeros(1, params.validationRepeats);
confAl = zeros(1, params.validationRepeats);
accTs = zeros(1, params.validationRepeats);
TPRts = zeros(1, params.validationRepeats);
TNRts = zeros(1, params.validationRepeats);

for run = 1:params.validationRepeats
    idxRand = randperm(blocks);
    idxTrain = reshape(blockIndices(idxRand(1:round(0.6 * blocks)),:)',1,[]);
    idxTest  = reshape(blockIndices(idxRand(round(0.6 * blocks)+1:end),:)',1,[]);

    % Vytvorenie siete
    net = patternnet(params.hiddenNeurons);
    net.trainParam.goal = params.goal;
    net.trainParam.epochs = params.epochs;
    net.trainParam.show = 10;
    net.trainParam.showWindow = params.gui;
    net.divideFcn = 'divideind';
    net.divideParam.trainInd = idxTrain;
    net.divideParam.testInd = idxTest;
    net.divideParam.valInd = [];

    % Trénovanie
    [net, tr] = train(net, inputData, targetOneHot);
    Y = net(inputData);  % simulácia siete na všetky vstupy

    % Chyby
    [confTr(run), ~] = confusion(targetOneHot(:,idxTrain), Y(:,idxTrain));
    [confTs(run), cmTs] = confusion(targetOneHot(:,idxTest), Y(:,idxTest));
    [confAl(run), cmAl] = confusion(targetOneHot, Y);

    % Presnosti
    accTs(run) = 1 - confTs(run);

    TP = cmTs(2,2) + cmTs(3,3);
    FN = cmTs(2,1) + cmTs(3,1) + cmTs(3,2);
    TPRts(run) = TP / (TP + FN);

    TN = cmTs(1,1);
    FP = cmTs(1,2) + cmTs(1,3) + cmTs(2,3);
    TNRts(run) = TN / (TN + FP);
end

% ===== PREHĽADOVÝ VÝSTUP (upravený) =====
fprintf('\n=== Súhrnný výstup klasifikácie ===\n\n');

fprintf('--- Chybovosť neurónovej siete (confusion) ---\n');
fprintf(' Maximálna chyba: tréning %.2f %% | testovanie %.2f %% | celkovo %.2f %%\n', ...
    max(confTr)*100, max(confTs)*100, max(confAl)*100);
fprintf(' Priemerná chyba: tréning %.2f %% | testovanie %.2f %% | celkovo %.2f %%\n', ...
    mean(confTr)*100, mean(confTs)*100, mean(confAl)*100);
fprintf(' Minimálna chyba: tréning %.2f %% | testovanie %.2f %% | celkovo %.2f %%\n\n', ...
    min(confTr)*100, min(confTs)*100, min(confAl)*100);

fprintf('--- Klasifikačné metriky ---\n');
fprintf(' Presnosť na testovacích dátach (ACC):      %.2f %%\n', mean(accTs)*100);
fprintf(' Senzitivita (TPR) pre triedy 2 a 3:         %.2f %%\n', mean(TPRts)*100);
fprintf(' Špecificita (TNR) pre normálne prípady:     %.2f %%\n\n', mean(TNRts)*100);

% ===== TEST VZORIEK (5 z každej triedy) =====
idxSample = [idx1(1:5), idx2(1:5), idx3(1:5)];
Ysample = net(inputData(:,idxSample));
expected = targetLabels(idxSample);
[~, predicted] = max(Ysample);
fprintf('Očakávané triedy   %s\n', num2str(expected));
fprintf('  Reálne  triedy   %s\n', num2str(predicted));
fprintf('Počet správnych odhadov %d\n', sum(expected == predicted));

% ===== KONFÚZNE MATICE PO POSLEDNOM BEHU =====
figure;
plotconfusion(targetOneHot(:,idxTrain), Y(:,idxTrain), 'Trénovacie dáta');

figure;
plotconfusion(targetOneHot(:,idxTest), Y(:,idxTest), 'Testovacie dáta');

figure;
plotconfusion(targetOneHot, Y, 'Celkové dáta');