% Pr�klad na aproxim�ciu nelin. funkcie pomocou NS typu
% MLP siet s 1 vstupom a 1 v�stupom
clear; clc;close all;
load datafun;

% vytvorenie �trukt�ry NS 
% 1 vstup - x suradnica
% 1 skryt� vrstva s poctom neur�nov 25 s funkciou 'tansig'
% 1 v�stup s funkciou 'purelin' - y suradnica
% tr�novacia met�da - Levenberg-Marquardt
pocet_neuronov = 250;
net=fitnet(pocet_neuronov);

% % vyber rozdelenia
% net.divideFcn='dividerand'; % n�hodn� rozdelenie

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


% Nastavenie parametrov tr�novania
net.trainParam.goal = 10^-4;     % Ukoncovacia podmienka na chybu
net.trainParam.show = 5;        % Frekvencia zobrazovania priebehu chyby tr�novania net.trainParam.epochs = 100;  % Max. po?et tr�novac�ch cyklov.
net.trainParam.epochs = 250;      % maximalny pocet trenovacich epoch.

% % Tr�novanie NS
net=train(net,x,y);

% % Simul�cia v�stupu NS
outnetsim = sim(net,x);

y1=y(indx_train);
y2=y(indx_test);

% vypocet chyby siete
out1 = outnetsim(indx_train);     % v�stup siete pre tr�novanie
out2 = outnetsim(indx_test);      % v�stup siete pre testovanie

% V�po�et ch�b
% SSE = suma �tvorcov rozdielov
SSE_train = sum((y1 - out1).^2);
SSE_test  = sum((y2 - out2).^2);

% MSE = priemern� �tvorcov� chyba
MSE_train = mean((y1 - out1).^2);
MSE_test  = mean((y2 - out2).^2);

% MAE = maxim�lna absol�tna chyba
MAE_train = max(abs(y1 - out1));
MAE_test  = max(abs(y2 - out2));

% Vykreslenie priebehov
% V�pis ch�b
fprintf('Chyby na tr�ningov�ch d�tach:\nSSE = %.6f, MSE = %.6f, MAE = %.6f\n', ...
         SSE_train, MSE_train, MAE_train);
fprintf('Chyby na testovac�ch d�tach:\nSSE = %.6f, MSE = %.6f, MAE = %.6f\n', ...
         SSE_test, MSE_test, MAE_test);

% Vizualiz�cia v�sledkov
figure;
hold on;

% Skuto�n� hodnoty d�t
plot(x(indx_train), y(indx_train), 'b+', 'DisplayName', 'Tr�novacie d�ta');  % modr� +
plot(x(indx_test), y(indx_test), 'g*', 'DisplayName', 'Testovacie d�ta');    % zelen� *

% V�stup siete ako �erven� �iara s kruhmi
plot(x, outnetsim, 'ro-', 'LineWidth', 1, 'MarkerSize', 4, ...
    'DisplayName', 'V�stup NS');

xlabel('x');
ylabel('y');
title(sprintf('Priebeh p�vodn�ch d�t a v�stupu NS pre %d neur�nov', pocet_neuronov));
legend('Location', 'best');
grid on;