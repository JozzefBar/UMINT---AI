function fitness = Fitness2(Pop)
    [popSize, numValues] = size(Pop);
    fitness = zeros(popSize, 1);
    
    for i = 1:popSize
        subject = Pop(i, :);

        [x1, x2, x3, x4, x5] = deal(subject(1), subject(2), subject(3), subject(4), subject(5));
        fitness(i) = 0.04 * x1 + 0.07 * x2 + 0.11 * x3 + 0.06 * x4 + 0.05 * x5;
        
        if sum(subject) > 10000000 
            fitness(i) = -inf;
            continue;
        end
        
        if x1 + x2 > 2500000
            fitness(i) = fitness(i) - 0.5*(x1 + x2 - 2500000);
        end
        
        if x5 > x4
            fitness(i) = fitness(i) - 0.5*(-x4 + x5);
        end
        
        if - 0.5*x1 - 0.5*x2 + 0.5*x3 + 0.5*x4 - 0.5*x5 > 0 
            fitness(i) = fitness(i) - 0.5*(- 0.5*x1 - 0.5*x2 + 0.5*x3 + 0.5*x4 - 0.5*x5);
        end
    end
end