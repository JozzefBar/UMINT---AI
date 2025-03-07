function Pop = genPermPop(popSize, numPoints)    
    % Inicializácia populácie
    Pop = zeros(popSize, numPoints);
    
    % Generovanie permutácií pre každého jedinca
    for i = 1:popSize
        % Prvý bod nastavíme na 1
        Pop(i, 1) = 1;
        
        % Posledný bod nastavíme na 20
        Pop(i, end) = 20;
        
        % Vygenerujeme náhodné body medzi 1 a 20 pre stredné pozície
        % Vylúčime pritom 1 a 20, ktoré sme už nastavili
        middlePoints = setdiff(2:19, [1, 20]);
        Pop(i, 2:end-1) = middlePoints(randperm(length(middlePoints), numPoints-2));
    end
end