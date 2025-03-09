clc; clear; close all;

J_function = [0.04 0.07 0.11 0.06 0.05];
Limit = 10000000;
Space = [zeros(1, 5); repmat(10000000, 1, 5)];
numGenes = 5;
popSize = 75;
maxIteration = 10;
numGeneration = 200;
%a = Fitness2([[0, 2500000, 2500000, 2500000, 2500000]], J_function, Limit);
Ampa = [-10000 10000 10000 10000 10000];
Ampm = [-1, 0, 0, 0, 0;  % Lower bounds for each gene
         2, 2, 2, 2, 2];  % Upper bounds for each gene

figure;
hold on;

bestSolutions = zeros(maxIteration, numGenes);
bestFitness = zeros(1, maxIteration);

for i = 1:maxIteration
    % Generovanie populácie
    Pop = genrpop(popSize, Space);
    bestFitnessHistory = zeros(1, numGeneration);
    
    for gen = 1:numGeneration
        fitnessValues = -Fitness2(Pop);

        bestSel = selbest(Pop, fitnessValues, [1,1,1]);  % Výber top 3
        bestSel2 = selbest(Pop, fitnessValues, 17); 
        bestSel3 = seltourn(Pop, fitnessValues, popSize - 20); %Výber rodičov
    
        concentrate = [bestSel2;  bestSel3];
        % Kríženie
        mix = intmedx(concentrate, 1);

        % Mutácia
        mutation = mutx(mix, 0.05, Space);   % Prvá mutácia 
        mutation = mutm(mutation, 0.4, Ampm, Space);
        mutation = muta(mutation, 0.4, Ampa, Space); % Druhá mutácia

        % Nahradenie populácie novou generáciou
        Pop = [bestSel; mutation];

        % Uloženie najlepšej fitness hodnoty
        bestFitnessHistory(gen) = min(fitnessValues);
    end
    
    [bestFit, bestIdx] = min(fitnessValues);
     
    % Uloženie najlepšieho riešenia
    bestSolutions(i, :) = Pop(bestIdx, :);
    bestFitness(i) = bestFit;
    
    % Vykreslenie priebehu fitness hodnôt
    plot(1:numGeneration, -bestFitnessHistory, 'LineWidth', 2);
    
    % Výpis najlepšieho riešenia
    fprintf("Iterácia %d: Najlepšia fitness = %.2f\n", i, -bestFit);
    fprintf("Rozloženie investícií: [%s]\n\n", num2str(bestSolutions(i, :), '%.2f '));
end

title('Priebeh fitness hodnôt počas evolúcie');
xlabel('Generácia');
ylabel('Najlepšia fitness hodnota');
grid on;
hold off;