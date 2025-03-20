%funkcia pre 2D graf 
clc; clear; close all;

x = -800:1:800;
Pop = x';
Fit = testfn3b(Pop);

max_iter = 10;
d = 5;

figure;
plot(x, Fit, 'r');
hold on;
grid on;

bestmin = inf;
xmin = inf;

for i = 1:max_iter
    x_current = randi([-800, 800]);
    F_current = testfn3b(x_current);
    plot(x_current, F_current, 'bo', 'MarkerFaceColor', 'k');
    [x_min, F_min] = findmin(x_current, F_current, d);

    if F_min < bestmin
        bestmin = F_min;
        xmin = x_min;
    end
end

function [x_current, F_current] = findmin(x_current, F_current, d)    
    while true
        x_left = x_current - d;
        x_right = x_current + d;

        F_left = testfn3b(x_left);
        F_right = testfn3b(x_right);

        [~, idx] = min([F_current, F_right, F_left]);

        if idx == 2 && x_right <= 800
            x_current = x_right;
            F_current = F_right;
        elseif idx == 3
            x_current = x_left;
            F_current = F_left;
        else
            %Výpis minima + nákres grafu
            plot(x_current, F_current, 'bo', 'MarkerFaceColor', 'g');
            fprintf("Nájdené minimum: x=%d  F(x)=%6f,\n", x_current, F_current)
            break;
        end

        plot(x_current, F_current, 'bo');
        pause(0.1);
    end
end

fprintf("\nNajmenšie minumum: x=%d F(x)=%6f", xmin, bestmin);
xlabel('x');
ylabel('y = F(x)');
title('New Schwefel Function');
hold off;