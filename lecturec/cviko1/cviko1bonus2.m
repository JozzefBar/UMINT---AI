%Funckia pre 3D funckiu (4D graf)
clc; clear;

% Rozsah pre všetky tri dimenzie
range = -800:1:800;

max_iter = 10;
d = 1;

for i = 1:max_iter
    % Inicializácia náhodného bodu v 3D priestore
    x_current = randi([-800, 800]);
    y_current = randi([-800, 800]);
    z_current = randi([-800, 800]);
    F_current = testfn3b([x_current, y_current, z_current]);
    findmin(x_current, y_current, z_current, F_current, d);
end

%Funkcia na nájdenie minima
function findmin(x_current, y_current, z_current, F_current, d)
    while true
        x_left = x_current - d;  x_right = x_current + d;
        y_left = y_current - d;  y_right = y_current + d;
        z_left = z_current - d;  z_right = z_current + d;
    
        % Výpočet hodnôt funkcie v susedných bodoch
        F_values = [
            F_current;
            testfn3b([x_right, y_current, z_current]); %doprava
            testfn3b([x_left, y_current, z_current]); %dolava 
            testfn3b([x_current, y_right, z_current]); %dopredu
            testfn3b([x_current, y_left, z_current]); %dozadu
            testfn3b([x_current, y_current, z_right]); %hore
            testfn3b([x_current, y_current, z_left])]; %dole
    
        [~, idx] = min(F_values);
    
        % Aktualizácia bodu podľa minima
        if idx == 2 && x_right <= 800
            x_current = x_right; 
            F_current = F_values(2);
        elseif idx == 3 && x_left >= -800
            x_current = x_left; 
            F_current = F_values(3);
        elseif idx == 4 && y_right <= 800
            y_current = y_right; 
            F_current = F_values(4);
        elseif idx == 5 && y_left >= -800
            y_current = y_left; 
            F_current = F_values(5);
        elseif idx == 6 && z_right <= 800
            z_current = z_right; 
            F_current = F_values(6);
        elseif idx == 7 && z_left >= -800
            z_current = z_left; 
            F_current = F_values(7);
        else
            %Výpis minima
            fprintf("Nájdené minimum: x=%d y=%d z=%d F(x, y, z)=%6f,\n", x_current, y_current, z_current, F_current);
            break;
        end
    end
end