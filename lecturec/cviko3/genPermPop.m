function Pop = genPermPop(popSize, numPoints)    
    % Inicializácia populácie
    Pop = zeros(popSize, numPoints);
    
    % Generovanie permutácií pre každého jedinca
    for i = 1:popSize
        Pop(i, 1) = 1;
        Pop(i, end) = 20;
        Pop(i, 2:end-1) = randperm(numPoints - 2) + 1;
    end
end