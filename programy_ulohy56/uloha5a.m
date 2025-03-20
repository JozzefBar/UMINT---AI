clear
% suradnice x,y,z piatich skupin bodov
load databody

% vykreslenie bodov podla skupin
h=figure;
plot3(data1(:,1),data1(:,2),data1(:,3),'b+')
hold on
plot3(data2(:,1),data2(:,2),data2(:,3),'co')
plot3(data3(:,1),data3(:,2),data3(:,3),'g*')
plot3(data4(:,1),data4(:,2),data4(:,3),'r*')
plot3(data5(:,1),data5(:,2),data5(:,3),'mx')

axis([0 1 0 1 0 1])
title('Data body')
xlabel('x')
ylabel('y')
zlabel('z')

% disp(' --------------- stlac klavesu --------------')
% pause

% vstupne a vystupne data na trenovanie neuronovej siete
% datainnet=[?]';
% dataoutnet=[?];

% vytvorenie struktury siete
% pocet_neuronov=[?];
% net = patternnet(pocet_neuronov);

% parametre rozdelenia dat na trenovanie, validacne a testovanie
% net.divideFcn='dividerand';
% net.divideParam.trainRatio=0.8;
% net.divideParam.valRatio=0;
% net.divideParam.testRatio=0.2;

% vlastne delenie dat, napr. indexove
% indx=randperm(250);
% net.divideFcn='divideind';      % indexove
% net.divideParam.trainInd=indx(1:150);
% net.divideParam.valInd=[];
% net.divideParam.testInd=indx(151:250);


% nastavenie parametrov trenovania 
% net.trainParam.goal = ?;       % ukoncovacia podmienka na chybu.
% net.trainParam.show = 20;           % frekvencia zobrazovania chyby
% net.trainParam.epochs = ?;        % maximalny pocet trenovacich epoch.
% net.trainParam.max_fail=12;

% trenovanie NS
% net = train(net,datainnet,dataoutnet);

% zobrazenie struktury siete
% view(net)

% simulacia vystupu NS pre trenovacie data
% testovanie NS
% outnetsim = sim(net,datainnet);

% chyba NS a dat
% err=(outnetsim-dataoutnet);

% percento neuspesne klasifikovanych bodov
% c = confusion(dataoutnet,outnetsim)

% kontingenËn· matica
% figure
% plotconfusion(dataoutnet,outnetsim)

% klasifikacia 5 novych bodov do tried
% doplniù