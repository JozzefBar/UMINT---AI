clc; clear; close all;

% Definovanie bodov (súradnice miest)
B = [0,0; 25,68; 12,75; 32,17; 51,64; 20,19; 52,87; 80,37; 35,82; 2,15; 50,90; 13,50; 85,52; 97,27; 37,67; 20,82; 49,0; 62,14; 7,60; 100,100];

numGenerations = 200;
numPoints = size(B, 1);   % Počet bodov v B
popSize = 50;
Fit = zeros(popSize, 1);  % Inicializujeme fitness hodnoty

bestFitnessHistory = zeros(numGenerations, 1);
bestPathHistory = zeros(numGenerations, numPoints);

Pop = genPermPop(popSize, numPoints);

figure(1);
h_fitness = plot(NaN, NaN);
xlabel('Generácia');
ylabel('Fitness (dĺžka cesty)');
title('Priebeh fitness počas generácií');
grid on;
xlim([1, numGenerations]);
hold on;

for gen = 1:numGenerations
    % Výpočet fitness pre každého jedinca v populácii
    for i = 1:popSize
        Fit(i) = Fits(Pop(i,:), B);
    end

    [minFitness, minIndex] = min(Fit);
    bestFitnessHistory(gen) = minFitness;
    bestPathHistory(gen, :) = Pop(minIndex, :);

    set(h_fitness, 'XData', 1:gen, 'YData', bestFitnessHistory(1:gen));
    drawnow;

    Pop = basicGA(Pop(:, 2:end-1), Fit);

    if mod(gen, 10) == 0
        fprintf('Generácia %d: Najlepšia fitness = %.2f\n', gen, minFitness);
    end
end


% Po ukončení cyklu, zobrazíme najlepšie výsledky
bestPath = bestPathHistory(end, :);
bestFitness = bestFitnessHistory(end);

% Zobrazenie výsledkov
disp('Najlepšia cesta (indexy bodov):');
disp(bestPath);
disp(['Dĺžka najlepšej cesty: ', num2str(bestFitness)]);

% Vykreslenie bodov a najlepšej cesty
figure(2);
plot(B(:,1), B(:,2), 'ko', 'MarkerFaceColor','k');  % Zobrazenie bodov
hold on;

fullPath = [bestPathHistory(end, :)];
pathX = zeros(1, length(fullPath));
pathY = zeros(1, length(fullPath));
for i = 1:length(fullPath)
    pathX(i) = B(fullPath(i), 1);
    pathY(i) = B(fullPath(i), 2);
end

% Vykresliť finálnu cestu
plot(pathX, pathY, 'r-', 'LineWidth', 3);

% Vyznačiť začiatok a koniec cesty
plot(B(1,1), B(1,2), 'gs', 'MarkerSize', 15, 'MarkerFaceColor', 'g'); % Začiatok
plot(B(20,1), B(20,2), 'rs', 'MarkerSize', 15, 'MarkerFaceColor', 'r'); % Koniec


% Pridáme čísla k bodom
for i = 1:size(B, 1)
    text(B(i, 1), B(i, 2), num2str(i), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
end

title('Najlepšia cesta');
xlabel('X');
ylabel('Y');
grid on;
hold off;