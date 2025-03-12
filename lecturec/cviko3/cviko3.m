clc; clear; close all;

B = [0,0; 25,68; 12,75; 32,17; 51,64; 20,19; 52,87; 80,37; 35,82; 2,15; 
     50,90; 13,50; 85,52; 97,27; 37,67; 20,82; 49,0; 62,14; 7,60; 100,100];

numGenerations = 500;
numPoints = size(B, 1);  % Počet bodov v B
popSize = 100;
MaxIter = 10;
Fit = zeros(popSize, 1);  % Inicializujeme fitness hodnoty

bestFitnessHistory = zeros(numGenerations, 1);
bestPathHistory = zeros(numGenerations, numPoints);

% Uchovanie najlepšieho riešenia naprieč všetkými behmi
globalBestFitness = inf;
globalBestPath = [];
globalBestPathIndex = 0;

colors = lines(MaxIter); % Vytvorí rôzne farby pre každý beh
figure; 
hold on;

for i = 1:MaxIter
    Pop = genPermPop(popSize, numPoints);
    index = 1;  % Reset indexu pri každom novom behu

    for gen = 1:numGenerations
        % Výpočet fitness pre každého jedinca v populácii
        for j = 1:popSize
            Fit(j) = Fitness(Pop(j,:), B);
        end

        [sortFitness, sortIndex] = sort(Fit);

        % Výber najlepších a ich kombinácia
        best = selbest(Pop, Fit, [2 2 2]);
        supbest = selbest(Pop, Fit, 10);
        supbest2 = seltourn(Pop, Fit, popSize - 16);
        concentrate = [supbest; supbest2];

        % Mutácia (2:19)
        mix = crosord(concentrate, 1);

        mut = swappart(mix(:, 2:19), 0.1);
        mut = invord(mut, 0.3);
        mut = swapgen(mut, 0.1);
        mix(:, 2:19) = mut;

        Pop = [best; mix];

        % Uloženie fitness a cesty len v rámci jedného behu
        bestFitnessHistory(index) = sortFitness(1,1);
        bestPathHistory(index, :) = Pop(sortIndex(1,1), :);
        index = index + 1;
    end

    fprintf('Run n. %d: Best Fitness = %.2f\n', i, bestFitnessHistory(end));

    % Aktualizácia globálne najlepšej cesty
    if bestFitnessHistory(end) < globalBestFitness
        globalBestFitness = bestFitnessHistory(end);
        globalBestPath = bestPathHistory(end, :);
        globalBestPathIndex = i;
    end

    % Vykreslenie fitness grafu pre aktuálny beh
    plot(1:numGenerations, bestFitnessHistory, 'Color', colors(i,:), 'LineWidth', 2);
end

% Pridanie legendy a popisov
xlabel('Generation');
ylabel('Fitness (path length)');
title('Fitness progress during all runs');
legend(arrayfun(@(x) ['Run n. ', num2str(x)], 1:MaxIter, 'UniformOutput', false), 'Location', 'northeast');
grid on;
hold off;

% Zobrazenie najlepšej cesty zo všetkých behov
fprintf('Best path from all runs:\n[');
fprintf('%d ', globalBestPath); 
fprintf("]\nLength of best run: %.2f (Iteration: %d)", globalBestFitness, globalBestPathIndex);

% Vykreslenie najlepšej cesty
figure;
plot(B(:,1), B(:,2), 'ko', 'MarkerFaceColor','k');  % Zobrazenie bodov
hold on;

fullPath = globalBestPath;
pathX = B(fullPath, 1);
pathY = B(fullPath, 2);

plot(pathX, pathY, 'r-', 'LineWidth', 3);
plot(B(1,1), B(1,2), 'gs', 'MarkerSize', 15, 'MarkerFaceColor', 'g'); % Začiatok
plot(B(20,1), B(20,2), 'rs', 'MarkerSize', 15, 'MarkerFaceColor', 'r'); % Koniec

for i = 1:size(B, 1)
    text(B(i, 1), B(i, 2), num2str(i), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
end

title('Globally best path');
xlabel('X');
ylabel('Y');
grid on;
hold off;
