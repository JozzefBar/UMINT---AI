clc; clear; close all;

max_generations = 500;
popsize = 100;
Space = [-800*ones(1, 10); 800*ones(1,10)];  % Rozsah hodnôt génov (hranice hodnôt, ktoré nepriesiahne)

% Uloženie legendy
legendEntries = cell(1, 5);

for rep = 1:5
    Newpop = genrpop(popsize, Space);

    bestFitnessHistory = zeros(1, max_generations);
    for gen = 1:max_generations

        %fitnessValues = testfn3b(Newpop); % Vyhodnotenie fitness - Schwefel
        fitnessValues = eggholder(Newpop); % Vyhodnotenie fitness -Eggholder

        % Výber
        bestnum = [1,1,1];
        selectedParents = selbest(Newpop, fitnessValues, bestnum);  % Výber top 3
        selectedParents2 = seltourn(Newpop, fitnessValues, popsize-3); %Výber rodičov

        % Kríženie
        mutation = crossov(selectedParents2, 2, 0);

        % Mutácia
        mutation = mutx(mutation, 0.1, Space);   % Prvá mutácia 
        mutation = muta(mutation, 0.1, ones(1,10), Space); % Druhá mutácia

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
title('Priebeh fitness funkcie 5 gen. (10D)');
grid on;
hold off;