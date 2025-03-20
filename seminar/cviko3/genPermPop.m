function Pop = genPermPop(popSize, numPoints)    
    Pop = zeros(popSize, numPoints);
    
    for i = 1:popSize
        Pop(i, 1) = 1;
        Pop(i, end) = 20;
        Pop(i, 2:end-1) = randperm(numPoints - 2) + 1;
    end
end