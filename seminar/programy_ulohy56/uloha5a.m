clear; clc;
% suradnice x,y,z piatich skupin bodov
load databody;

% vykreslenie bodov podla skupin
h=figure;
plot3(data1(:,1),data1(:,2),data1(:,3),'b+');
hold on;
plot3(data2(:,1),data2(:,2),data2(:,3),'co');
plot3(data3(:,1),data3(:,2),data3(:,3),'g*');
plot3(data4(:,1),data4(:,2),data4(:,3),'r*');
plot3(data5(:,1),data5(:,2),data5(:,3),'mx');

axis([0 1 0 1 0 1]);
title('Data body');
xlabel('x');
ylabel('y');
zlabel('z');


% disp(' --------------- stlac klavesu --------------')
% pause

% vstupne a vystupne data na trenovanie neuronovej siete
datainnet = [data1; data2; data3; data4; data5]';
dataoutnet = [repmat([1;0;0;0;0],1,size(data1,1)), ...
              repmat([0;1;0;0;0],1,size(data2,1)), ...
              repmat([0;0;1;0;0],1,size(data3,1)), ...
              repmat([0;0;0;1;0],1,size(data4,1)), ...
              repmat([0;0;0;0;1],1,size(data5,1))];

% vytvorenie struktury siete
pocet_neuronov= 11;
net = patternnet(pocet_neuronov);


% parametre rozdelenia dat na trenovanie, validacne a testovanie
net.divideFcn='dividerand';
net.divideParam.trainRatio=0.8;
net.divideParam.valRatio=0;
net.divideParam.testRatio=0.2;

% vlastne delenie dat, napr. indexove
%indx=randperm(250);
%net.divideFcn='divideind';      % indexove
%net.divideParam.trainInd=indx(1:150);
%net.divideParam.valInd=[];
%net.divideParam.testInd=indx(151:250);


% nastavenie parametrov trenovania 
net.trainParam.goal = 10^-4;       % ukoncovacia podmienka na chybu.
net.trainParam.show = 20;           % frekvencia zobrazovania chyby
net.trainParam.epochs = 200;        % maximalny pocet trenovacich epoch.
net.trainParam.max_fail=12;      

% trenovanie NS
net = train(net,datainnet,dataoutnet);

% zobrazenie struktury siete
view(net)

% simulacia vystupu NS pre trenovacie data
% testovanie NS
outnetsim = sim(net,datainnet);

% chyba NS a dat
err=(outnetsim-dataoutnet);

% percento neuspesne klasifikovanych bodov
c = confusion(dataoutnet,outnetsim);

% kontingenèná matica
figure
plotconfusion(dataoutnet,outnetsim)

% klasifikacia 5 novych bodov do tried
% doplni

newPoints = [0.2 0.3 0.7;   % bod 1
            0.8 0.2 0.4;   % bod 2
            0.5 0.5 0.5;   % bod 3
            0.1 0.9 0.1;   % bod 4
            0.6 0.6 0.6]'; % bod 5 

output = sim(net, newPoints);         % vıstupy siete
[~, class] = max(output, [], 1);    % indexy najvyšších hodnôt = predikované triedy
disp('Triedy novych bodov:');
disp(class);

%Vizualizácia novıch bodov v 3D grafe
figure(h);
hold on;

% Farby pre kadú triedu, ktorú predikovala sie
farby = {'b','c','g','r','m'};

% Pole pre úchopy grafickıch objektov (na legendu)
hLegend = gobjects(1,5);

for i = 1:length(class)
    hLegend(i) = plot3(newPoints(1,i), newPoints(2,i), newPoints(3,i), ...
          'o', 'MarkerSize', 10, 'MarkerEdgeColor', 'k', ...
          'MarkerFaceColor', farby{class(i)});
end

% Legenda vrátane novıch bodov
legend('Skupina 1','Skupina 2','Skupina 3','Skupina 4','Skupina 5', ...
       'Novı bod 1','Novı bod 2','Novı bod 3','Novı bod 4','Novı bod 5');