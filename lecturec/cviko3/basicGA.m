function [NewPop] = basicGA(Pop, Fit)
    % Pop - aktuálna populácia
    % Fit - fitness hodnoty pre každého jedinca v populácii
    % NewPop - nová populácia
  
    popSize = size(Pop, 1);

    % Parametre pre selekciu
    Nums = [1, 1, 1, 1, 1];
    
    % Výber
    selectedParents = selbest(Pop, Fit, Nums);
    selectedParents2 = seltourn(Pop, Fit, popSize-5);

    % Kríženie
    mutation = crosord(selectedParents2, 0);

    % Mutácia
    mutation = swappart(mutation, 0.1);
    mutation = swapgen(mutation, 0.1);

    % Nahradenie populácie novou generáciou

    % Spojíme všetky stĺpce do novej populácie
    % Spojíme selectedParents (5x18) a mutation (45x18) do matice 50x18
    NewPop = [selectedParents; mutation];

    % Teraz pridáme stĺpec s jedničkami na začiatok a stĺpec s hodnotami 20 na koniec
    NewPop = [ones(50, 1), NewPop, 20*ones(50, 1)];

end