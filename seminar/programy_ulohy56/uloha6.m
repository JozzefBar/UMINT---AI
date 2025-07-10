close all; clear; clc;

% pocet neuronov
neurons = 180;

% nacitanie, priprava dat
load CTGdata
inputData = NDATA';
targetLabels = typ_ochorenia(:)';
targetOut = full(ind2vec(targetLabels));

% Rozdelenie podla tried a zamiesanie
idx1 = find(targetLabels == 1);
idx2 = find(targetLabels == 2);
idx3 = find(targetLabels == 3);
idx1 = idx1(randperm(length(idx1)));
idx2 = idx2(randperm(length(idx2)));
idx3 = idx3(randperm(length(idx3)));

% Blokove rozdelenie pre krizovu validaciu
blocks = 55;
blockIndices = [];
for i = 1:blocks
    r1 = (1 + floor(length(idx1)/blocks)*(i-1)):(floor(length(idx1)/blocks)*i);
    r2 = (1 + floor(length(idx2)/blocks)*(i-1)):(floor(length(idx2)/blocks)*i);
    r3 = (1 + floor(length(idx3)/blocks)*(i-1)):(floor(length(idx3)/blocks)*i);
    blockIndices(i,:) = [idx1(r1), idx2(r2), idx3(r3)];
end

% metriky
repeats = 5;
confTr = zeros(1, repeats);
confTs = zeros(1, repeats);
confAl = zeros(1, repeats);
accTs = zeros(1, repeats);

bestAcc = -inf;

for run = 1:repeats
    idxRand = randperm(blocks);
    idxTrain = reshape(blockIndices(idxRand(1:round(0.6 * blocks)),:)',1,[]);
    idxTest  = reshape(blockIndices(idxRand(round(0.6 * blocks)+1:end),:)',1,[]);

    % Vytvorenie a nastavenie siete
    net = patternnet(neurons);
    net.trainParam.goal = 1e-2;
    net.trainParam.epochs = 200;

    net.divideFcn = 'divideind';
    net.divideParam.trainInd = idxTrain;
    net.divideParam.testInd = idxTest;
    net.divideParam.valInd = [];

    [net, tr] = train(net, inputData, targetOut);
    Y = net(inputData);

    % Metiky pre current run
    [confTr(run), ~] = confusion(targetOut(:,idxTrain), Y(:,idxTrain));
    [confTs(run), ~] = confusion(targetOut(:,idxTest), Y(:,idxTest));
    [confAl(run), ~] = confusion(targetOut, Y);
    accTs(run) = 1 - confTs(run);

    if accTs(run) > bestAcc
        bestAcc = accTs(run);
        bestNet = net;
        bestIdxTrain = idxTrain;
        bestIdxTest = idxTest;
        bestY = Y;
        bestTR = tr;
        bestRun = run;
    end
end

% Výsledky
fprintf('\n=== Výsledky po %d opakovaniach ===\n', repeats);
fprintf('Najlepšia sieť bola v behu č. %d (počet neurónov: %d) \n', bestRun, neurons);

fprintf('\n--- Presnosti ---\n');
fprintf('Testovacia presnosť: MIN %.2f %% | MAX %.2f %% | PRIEMER %.2f %%\n', min(accTs)*100, max(accTs)*100, mean(accTs)*100);
fprintf('Trénovacia presnosť: MIN %.2f %% | MAX %.2f %% | PRIEMER %.2f %%\n', (1 - max(confTr))*100, (1 - min(confTr))*100, (1 - mean(confTr))*100);
fprintf('Celkova presnosť:    MIN %.2f %% | MAX %.2f %% | PRIEMER %.2f %%\n', (1 - max(confAl))*100, (1 - min(confAl))*100, (1 - mean(confAl))*100);

% Výpočet metrík pre najlepšiu sieť
finalY = bestNet(inputData);
[~, cmTsBest] = confusion(targetOut(:,bestIdxTest), finalY(:,bestIdxTest));

TP = cmTsBest(2,2) + cmTsBest(3,3);
FN = cmTsBest(2,1) + cmTsBest(3,1);
TN = cmTsBest(1,1);
FP = cmTsBest(1,2) + cmTsBest(1,3);
TPR_best = TP / (TP + FN);
TNR_best = TN / (TN + FP);
acc_best = (TP + TN) / (TP + TN + FP + FN);

fprintf('\n--- Metriky najlepšej siete ---\n');
fprintf('Presnosť (ACC):    %.2f %%\n', acc_best * 100);
fprintf('Senzitivita (TPR): %.2f %%\n', TPR_best * 100);
fprintf('Špecificita (TNR): %.2f %%\n', TNR_best * 100);

% Vizualizácie
figure; plotconfusion(targetOut(:,bestIdxTrain), bestY(:,bestIdxTrain), 'Trénovacie dáta');
figure; plotconfusion(targetOut(:,bestIdxTest), bestY(:,bestIdxTest), 'Testovacie dáta');
figure; plotconfusion(targetOut, bestY, 'Celkove dáta');
figure; plotperform(bestTR);

% Testovanie vzoriek
sampleIdx = [idx1(1:5), idx2(1:5), idx3(1:5)];
sampleOutput = bestNet(inputData(:,sampleIdx));
[~, predicted] = max(sampleOutput);
expected = targetLabels(sampleIdx);
fprintf('\nOčakávané triedy:   %s\n', num2str(expected));
fprintf('Predikované triedy: %s\n', num2str(predicted));
fprintf('Správne odhady: %d z %d\n', sum(expected == predicted), length(expected));
