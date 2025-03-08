clc; clear; close all;

% Definovanie bodov (súradnice miest)
B = [0,0; 25,68; 12,75; 32,17; 51,64; 20,19; 52,87; 80,37; 35,82; 2,15; 50,90; 13,50; 85,52; 97,27; 37,67; 20,82; 49,0; 62,14; 7,60; 100,100];

numGenerations = 500;
numPoints = size(B, 1);   % Počet bodov v B
popSize = 100;
Fit = zeros(popSize, 1);  % Inicializujeme fitness hodnoty

bestFitnessHistory = zeros(numGenerations, 1);
bestPathHistory = zeros(numGenerations, numPoints);

Pop = genPermPop(popSize, numPoints);

EliteCount = 6; % Počet najlepších
OthersCount = popSize - EliteCount; % Zvysok

for gen = 1:numGenerations
    % Výpočet fitness pre každého jedinca v populácii
    for i = 1:popSize
        Fit(i) = Fits(Pop(i,:), B);
    end

    [sortFitness, sortIndex] = sort(Fit);
    elite = Pop(sortIndex(1:EliteCount),1:20);
    randomgen = randperm(popSize);
    Others = cat(1,Pop(sortIndex(1:OthersCount*(1/2)), 1:20), Pop(randomgen(1:OthersCount*(1/2)),:));

    mut =  swappart(Others(1:OthersCount,2:19),0.1);
    mut = swapgen(mut(1:OthersCount,1:18), 0.1);
    mut = invord(mut(1:OthersCount,1:18),0.3);

    repair = cat(2, ones(popSize-EliteCount,1),mut, 20*ones(popSize-EliteCount,1));
    Pop = cat(1,elite,repair);

    bestFitnessHistory(gen) = sortFitness(1,1);
    bestPathHistory(gen, :) = Pop(sortIndex(1,1), :);

    if mod(gen, 20) == 0
        fprintf('Generácia %d: Najlepšia fitness = %.2f\n', gen, bestFitnessHistory(gen));
    end
end

% Vykreslenie fitness grafu na konci
figure;
plot(1:numGenerations, bestFitnessHistory, 'b-', 'LineWidth', 2);
xlabel('Generácia');
ylabel('Fitness (dĺžka cesty)');
title('Priebeh fitness počas generácií');
grid on;

% Po ukončení cyklu, zobrazíme najlepšie výsledky
bestPath = bestPathHistory(end, :);
bestFitness = bestFitnessHistory(end);

disp('Najlepšia cesta (indexy bodov):');
disp(bestPath);
disp(['Dĺžka najlepšej cesty: ', num2str(bestFitness)]);

% Vykreslenie bodov a najlepšej cesty
figure;
plot(B(:,1), B(:,2), 'ko', 'MarkerFaceColor','k');  % Zobrazenie bodov
hold on;

fullPath = [bestPathHistory(end, :)];
pathX = B(fullPath, 1);
pathY = B(fullPath, 2);

% Vykresliť finálnu cestu
plot(pathX, pathY, 'r-', 'LineWidth', 3);

% Vyznačiť začiatok a koniec cesty
plot(B(1,1), B(1,2), 'gs', 'MarkerSize', 15, 'MarkerFaceColor', 'g'); % Začiatok
plot(B(20,1), B(20,2), 'rs', 'MarkerSize', 15, 'MarkerFaceColor', 'r'); % Koniec

% Pridanie čísiel k bodom
for i = 1:size(B, 1)
    text(B(i, 1), B(i, 2), num2str(i), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
end

title('Najlepšia cesta');
xlabel('X');
ylabel('Y');
grid on;
hold off;
