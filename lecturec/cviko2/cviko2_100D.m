clc; clear; close all;

%100 premennych
max_generations = 600;
popSize = 1000;
Space = [-800*ones(1, 100); 800*ones(1,100)];  % Rozsah hodnôt génov

% Uloženie legendy
legendEntries = cell(1, 5);

for rep = 1:5
    Newpop = genrpop(popSize, Space);

    bestFitnessHistory = zeros(1, max_generations);
    for gen = 1:max_generations

        fitnessValues = testfn3b(Newpop); % Vyhodnotenie fitness - Schwefel

        % Výber
        bestnum1000 = [9,5,5,3,3];
        selectedParents = selbest(Newpop, fitnessValues, bestnum1000);  % Výber top 25
        selectedParents2 = selsus(Newpop, fitnessValues, popSize-25); % Výber rodičov, stochastická funkcia

        % Kríženie
        mutation = crossov(selectedParents2, 2, 0);

        % Mutácia
        mutation = mutx(mutation, 0.1, Space);   % Prvá mutácia 
        mutation = muta(mutation, 0.1, ones(1,100), Space); % Druhá mutácia

        % Nahradenie populácie novou generáciou
        Newpop = [selectedParents; mutation];

        % Uloženie najlepšej fitness hodnoty
        bestFitnessHistory(gen) = min(fitnessValues);
    end

    % Vykreslenie priebehu fitness pre každé opakovanie s rôznou farbou
    plot(1:max_generations, bestFitnessHistory, 'LineWidth', 2);
    hold on;
    
    fprintf("Najmenší fitness: %.3f\n", bestFitnessHistory(gen));

    % Uloženie legendy pre každé opakovanie
    legendEntries{rep} = ['Gen ' num2str(rep)];
end


% Pridanie legendy
legend(legendEntries);

% Pridanie názvov a popisov grafu
xlabel('Generácia');
ylabel('Minimálny fitness');
title('Priebeh fitness funkcie 5 gen. (100D)');
grid on;
hold off;