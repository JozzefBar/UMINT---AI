% Príklad na aproximáciu nelin. funkcie pomocou NS typu
% MLP siet s 1 vstupom a 1 vıstupom
clear
load datafun

% vytvorenie štruktúry NS 
% 1 vstup - x suradnica
% 1 skrytá vrstva s poctom neurónov 25 s funkciou 'tansig'
% 1 vıstup s funkciou 'purelin' - y suradnica
% trénovacia metóda - Levenberg-Marquardt
% pocet_neuronov=?;
% net=fitnet(pocet_neuronov);

% % vyber rozdelenia
% net.divideFcn='dividerand'; % náhodné rozdelenie

% % net.divideFcn='divideblock'; % blokove

% net.divideFcn='divideint';  % kazdy n-ta vzorka

% %net.divideFcn='dividetrain';  % iba trenovacie

%  net.divideParam.trainRatio=0.6;
%  net.divideParam.valRatio=0;
%  net.divideParam.testRatio=0.4;


% net.divideFcn='divideind';      % indexove
% net.divideParam.trainInd=indx_train;
% net.divideParam.valInd=[];
% net.divideParam.testInd=indx_test;


% Nastavenie parametrov trénovania
% net.trainParam.goal = ?;     % Ukoncovacia podmienka na chybu
% net.trainParam.show = 5;        % Frekvencia zobrazovania priebehu chyby trénovania net.trainParam.epochs = 100;  % Max. po?et trénovacích cyklov.
% net.trainParam.epochs =?;      % maximalny pocet trenovacich epoch.

% % Trénovanie NS
% net=train(net,x,y);

% % Simulácia vıstupu NS
% outnetsim = sim(net,x);

% Simulácia vıstupu NS
% outnetsim = sim(net,x);
y1=y(indx_train);
y2=y(indx_test);

% vypocet chyby siete
% doplni 

% Vykreslenie priebehov
figure
plot(x(indx_train),y1,'b+',x(indx_test),y2,'g*')
% hold on
% plot(x,outnetsim,'-or')


