function [Fit] = Fitness(popSize, B) 
    % popSize - permutácia miest (každý riadok je jedinec)
    % B - matica súradníc všetkých miest (každý riadok je [x, y])

    [lpop, ~] = size(popSize); % Počet jedincov v populácii
    Fit = zeros(1, lpop);

    for i = 1:lpop
        vekt = popSize(i, :);
        totalDistance = 0;
        
        % Výpočet vzdialenosti medzi bodmi v permutácii
        for j = 1:length(vekt)-1
            bodA = B(vekt(j), :);   % Súradnice mesta A
            bodB = B(vekt(j+1), :); % Súradnice mesta B
            
            % Výpočet euklidovskej vzdialenosti
            distance = sqrt((bodB(1) - bodA(1))^2 + (bodB(2) - bodA(2))^2);
            totalDistance = totalDistance + distance;
        end
        
        Fit(i) = totalDistance;
    end
end
