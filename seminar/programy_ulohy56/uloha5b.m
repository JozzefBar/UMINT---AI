% Príklad na aproximáciu nelin. funkcie pomocou NS typu
% MLP siet s 1 vstupom a 1 výstupom
clear; clc;close all;
load datafun;

% vytvorenie štruktúry NS 
% 1 vstup - x suradnica
% 1 skrytá vrstva s poctom neurónov 25 s funkciou 'tansig'
% 1 výstup s funkciou 'purelin' - y suradnica
% trénovacia metóda - Levenberg-Marquardt
pocet_neuronov = 250;
net=fitnet(pocet_neuronov);

% % vyber rozdelenia
% net.divideFcn='dividerand'; % náhodné rozdelenie

% % net.divideFcn='divideblock'; % blokove

% net.divideFcn='divideint';  % kazdy n-ta vzorka

% %net.divideFcn='dividetrain';  % iba trenovacie

%  net.divideParam.trainRatio=0.6;
%  net.divideParam.valRatio=0;
%  net.divideParam.testRatio=0.4;


net.divideFcn='divideind';      % indexove
net.divideParam.trainInd=indx_train;
net.divideParam.valInd=[];
net.divideParam.testInd=indx_test;


% Nastavenie parametrov trénovania
net.trainParam.goal = 10^-4;     % Ukoncovacia podmienka na chybu
net.trainParam.show = 5;        % Frekvencia zobrazovania priebehu chyby trénovania net.trainParam.epochs = 100;  % Max. po?et trénovacích cyklov.
net.trainParam.epochs = 250;      % maximalny pocet trenovacich epoch.

% % Trénovanie NS
net=train(net,x,y);

% % Simulácia výstupu NS
outnetsim = sim(net,x);

y1=y(indx_train);
y2=y(indx_test);

% vypocet chyby siete
out1 = outnetsim(indx_train);     % výstup siete pre trénovanie
out2 = outnetsim(indx_test);      % výstup siete pre testovanie

% Výpoèet chýb
% SSE = suma štvorcov rozdielov
SSE_train = sum((y1 - out1).^2);
SSE_test  = sum((y2 - out2).^2);

% MSE = priemerná štvorcová chyba
MSE_train = mean((y1 - out1).^2);
MSE_test  = mean((y2 - out2).^2);

% MAE = maximálna absolútna chyba
MAE_train = max(abs(y1 - out1));
MAE_test  = max(abs(y2 - out2));

% Vykreslenie priebehov
% Výpis chýb
fprintf('Chyby na tréningových dátach:\nSSE = %.6f, MSE = %.6f, MAE = %.6f\n', ...
         SSE_train, MSE_train, MAE_train);
fprintf('Chyby na testovacích dátach:\nSSE = %.6f, MSE = %.6f, MAE = %.6f\n', ...
         SSE_test, MSE_test, MAE_test);

% Vizualizácia výsledkov
figure;
hold on;

% Skutoèné hodnoty dát
plot(x(indx_train), y(indx_train), 'b+', 'DisplayName', 'Trénovacie dáta');  % modré +
plot(x(indx_test), y(indx_test), 'g*', 'DisplayName', 'Testovacie dáta');    % zelené *

% Výstup siete ako èervená èiara s kruhmi
plot(x, outnetsim, 'ro-', 'LineWidth', 1, 'MarkerSize', 4, ...
    'DisplayName', 'Výstup NS');

xlabel('x');
ylabel('y');
title(sprintf('Priebeh pôvodných dát a výstupu NS pre %d neurónov', pocet_neuronov));
legend('Location', 'best');
grid on;