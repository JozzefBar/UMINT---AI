% Príklad na aproximáciu nelin. funkcie pomocou NS typu
% MLP siet s 1 vstupom a 1 výstupom
clear; clc;
load datafun;

% vytvorenie štruktúry NS 
% 1 vstup - x suradnica
% 1 skrytá vrstva s poctom neurónov 25 s funkciou 'tansig'
% 1 výstup s funkciou 'purelin' - y suradnica
% trénovacia metóda - Levenberg-Marquardt
pocet_neuronov = 60;
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
net.trainParam.epochs = 500;      % maximalny pocet trenovacich epoch.

% % Trénovanie NS
net=train(net,x,y);

% % Simulácia výstupu NS
outnetsim = sim(net,x);

y1=y(indx_train);
y2=y(indx_test);

% vypocet chyby siete
out1 = outnetsim(indx_train);     % výstup siete pre trénovanie
out2 = outnetsim(indx_test);      % výstup siete pre testovanie

% === 6. Výpoèet chýb ===
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

% === 7. Vizualizácia výsledkov ===
figure;
hold on;

% Skutoèné hodnoty
plot(x(indx_train), y(indx_train), 'b+', 'DisplayName', 'Skutoèné hodnoty trénovacie dáta');
plot(x(indx_test), y(indx_test), 'g*', 'DisplayName', 'Skutoèné hodnoty testovacie dáta');

% Predikované hodnoty siete
plot(x(indx_train), outnetsim(indx_train), 'mo', 'DisplayName', 'Predikované hodnoty trénovacie dáta');
plot(x(indx_test), outnetsim(indx_test), 'ks', 'DisplayName', 'Predikované hodnoty testovacie dáta');

xlabel('x');
ylabel('y');
title('Porovnanie skutoèných a predikovaných hodnôt');
legend('Location','best');
grid on;


