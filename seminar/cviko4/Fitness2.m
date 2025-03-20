function fitness = Fitness2(Pop, Limit, J_function)   %Degree penalty
    [popSize, ~] = size(Pop);
    fitness = zeros(popSize, 1);
    
    for i = 1:popSize
        subject = Pop(i, :);

        [x1, x2, x3, x4, x5] = deal(subject(1), subject(2), subject(3), subject(4), subject(5));
        fitness(i) = J_function(1)*x1 + J_function(2)*x2 + J_function(3)*x3 + J_function(4)*x4 + J_function(5)*x5;
        
        mistakeNum = 0;
        if sum(subject) > Limit 
            mistakeNum = mistakeNum + 1;
        end
        
        if x1 + x2 > Limit/4
            mistakeNum = mistakeNum + 1;
        end
        
        if x5 > x4
            mistakeNum = mistakeNum + 1;
        end
        
        if - 0.5*x1 - 0.5*x2 + 0.5*x3 + 0.5*x4 - 0.5*x5 > 0 
            mistakeNum = mistakeNum + 1;
        end
        fitness(i) = fitness(i) - Limit*mistakeNum;
    end
end