%funkcia pre 3D graf 
clc; clear; close all;

x = -800:1:800; 
y = -800:1:800;
[X, Y] = meshgrid(x, y);

Pop = [X(:), Y(:)];  
Z = testfn3b(Pop);  
Z = reshape(Z, size(X));

figure;
surf(X, Y, Z, 'EdgeColor', 'none');
colormap jet;     
colorbar;
grid on;
hold on;

max_iter = 10;
d = 5;

for i = 1:max_iter
    x_current = randi([-800, 800]);
    y_current = randi([-800, 800]);
    F_current = testfn3b([x_current, y_current]);
    plot3(x_current, y_current, F_current, 'bo', 'MarkerFaceColor', 'k');
    findmin(x_current, y_current, F_current, d);
end

%Funkcia na nájdenie minima
function findmin(x_current, y_current, F_current, d)
    while true
        x_left = x_current - d;
        x_right = x_current + d;
        y_left = y_current - d;
        y_right = y_current + d;
    
        % Výpočet hodnôt funkcie v susedných bodoch
        F_left = testfn3b([x_left, y_current]);
        F_right = testfn3b([x_right, y_current]);
        F_up = testfn3b([x_current, y_right]);
        F_down = testfn3b([x_current, y_left]);

        [~, idx] = min([F_current, F_right, F_left, F_up, F_down]);
        
        % Aktualizácia bodu podľa minima
        if idx == 2 && x_right <= 800
            x_current = x_right;
            F_current = F_right;
        elseif idx == 3 && x_left >= -800
            x_current = x_left;
            F_current = F_left;
        elseif idx == 4 && y_right <= 800
            y_current = y_right;
            F_current = F_up;
        elseif idx == 5 && y_left >= -800
            y_current = y_left;
            F_current = F_down;
        else
            %Výpis minima + nákres grafu
            plot3(x_current, y_current, F_current, 'bo', 'MarkerFaceColor', 'g');
            fprintf("Nájdené minimum: x=%d y=%d F(x, y)=%6f,\n", x_current, y_current, F_current)
            break;
        end
        
        plot3(x_current, y_current, F_current, 'bo');
    end
end

xlabel('x');
ylabel('y');
zlabel('z = F(x,y)')
title('New Schwefel Function - 3D');
hold off;