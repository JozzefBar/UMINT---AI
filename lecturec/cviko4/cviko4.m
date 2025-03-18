clc; clear; close all;

J_function = [0.04 0.07 0.11 0.06 0.05];
Limit = 10000000;
Space = [zeros(1, 5); repmat(10000000, 1, 5)];
numGenes = 5;
popSize = 100;
maxIteration = 10;
numGeneration = 2000;
Ampa = [100000 100000 100000 100000 100000];
%Ampm = [0, 0, 0, 0, 0;
%         1, 1, 1, 1, 1];

figure;
hold on;

bestSolutions = zeros(maxIteration, numGenes);
bestFitness = zeros(1, maxIteration);

for i = 1:maxIteration
    Pop = genrpop(popSize, Space);
    bestFitnessHistory = zeros(1, numGeneration);
    
    for gen = 1:numGeneration
        %fitnessValues = -Fitness1(Pop, Limit, J_function);   %Dead penalty
        %fitnessValues = -Fitness2(Pop, Limit, J_function);  %Degree penalty
        fitnessValues = -Fitness3(Pop, Limit, J_function);  %Penalty to the degree of violation of the restrictions

        bestSel = selbest(Pop, fitnessValues, [2 2]);
        bestSel2 = selbest(Pop, fitnessValues, [2 2 2]);
        bestSel3 = seltourn(Pop, fitnessValues, popSize - 10);
            
        mix1 = crossov(bestSel2, 2, 0); 
        mix2 = crossov(bestSel3, 2, 0); 

        mutation1 = muta(mix1, 0.3, Ampa, Space);
        mutation2 = mutx(mix2, 0.2, Space);

        Pop = [bestSel; mutation1; mutation2];

        bestFitnessHistory(gen) = min(fitnessValues);
    end
    
    [bestFit, bestIdx] = min(fitnessValues);
    bestSolutions(i, :) = Pop(bestIdx, :);
    bestFitness(i) = bestFit;
    
    plot(1:numGeneration, -bestFitnessHistory, 'LineWidth', 2);
    
    fprintf("Iteration %d: Best Fitness = %.2f\n", i, -bestFit);
    fprintf("Investment distribution: [%s]\n\n", num2str(bestSolutions(i, :), '%.2f '));
end


title('The course of fitness values during evolution');
xlabel('Generation');
ylabel('Best Fitness Value');
ylim([0 8*10^5]);
grid on;
hold off;

% Zistenie celkovo najlepšieho riešenia
[globalBestFitness, globalBestIdx] = min(bestFitness);
globalBestSolution = bestSolutions(globalBestIdx, :);

fprintf("\nOverall Best Fitness: %.2f (iteration %d)\n", -globalBestFitness, globalBestIdx);
fprintf("Best Investment Distribution: [%s]\n", num2str(globalBestSolution, '%.2f '));