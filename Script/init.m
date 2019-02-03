%structure contenant les fonctions d'apprentissage test�es
trainFcs = [struct('name', 'trainrp') struct('name', 'trainscg') struct('name', 'trainlm')];

%structure contenant les fonctions de performance test�es
PerformanceFunction = [struct('name', 'sse') struct('name', 'mse')];

%le nombre de neurones dans la couche cach�e (une couche) 
NbNeurons = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

%le nombre de neurones dans la couche cach�e (deux couches) 
NbNeurons2 = [1, 2, 3, 4, 5];

%le pourcentage de partitionnement pris � chaque fois pour l'apprentissage
%trainRatio
PercentPartition = [50, 60, 70, 80];

fprintf('-------- Une seule couche cahch�e --------\n')
for l = 1 : length(PerformanceFunction)
    fprintf('Fonction de performance :  ')
    disp(PerformanceFunction(l))
    for k = 1 : length(PercentPartition)
        fprintf('Train Ratio :  ')
        disp(PercentPartition(k))
        for j = 1 : length(trainFcs)
            fprintf('Fonction d''apprentissage :  ')
            disp(trainFcs(j))
            %cr�ation des r�seaux de neurones selon NbNeurones
            for i = 1 : 1 : length(NbNeurons)
                %cr�ation du r�seau de neurones
                net = newff(NNInPut, NNTarget1, NbNeurons(i));
                net.trainFcn = trainFcs(j).name;
                net.performFcn = PerformanceFunction(l).name;
                
                %partitionnement de l'ensemble d'apprentissage
                net.divideParam.trainRatio = PercentPartition(k)/100; 
                net.divideParam.valRatio = ((100-PercentPartition(k))/2)/100;   
                net.divideParam.testRatio = ((100-PercentPartition(k))/2)/100;  
                [trainV, valV, testV, trainInd, valInd, testInd] = dividerand(NNInPut, net.divideParam.trainRatio, net.divideParam.valRatio, net.divideParam.testRatio);
                [trainT, valT, testT] = divideind(NNTarget1, trainInd, valInd, testInd);

                %modification des parameteres du r�seau
                net.trainParam.epochs = 500; 
                net.trainParam.show = 50;
                net.trainParam.lr = 0.3; 
                net.trainParam.max_fail = 50;

                %appel de la fonction ntrain qui fait 10 fois
                %l'apprentissage du meme r�seau puis retoune le meilleur
                fprintf('Nombre de neurones :')
                disp(NbNeurons(i))
                ntrain(net, NNInPut, NNTarget1, 10);
            end
        end
    end
end

fprintf('-------- Deux couches cahch�es --------\n')
for l = 1 : length(PerformanceFunction)
    fprintf('Fonction de performance :  ')
    disp(PerformanceFunction(l))
    for k = 1 : length(PercentPartition)
        fprintf('Train Ratio :  ')
        disp(PercentPartition(k))
        for j = 1 : length(trainFcs)
            fprintf('Fonction d''apprentissage :  ')
            disp(trainFcs(j))
            %cr�ation des r�seaux de neurones selon NbNeurones2
            for i = 1 : 1 : length(NbNeurons2)
                %cr�ation du r�seau de neurones
                net = newff(NNInPutNorm, NNTarget, {NbNeurons2(i), NbNeurons2(i)});
                net.trainFcn = trainFcs(j).name;
                net.performFcn = PerformanceFunction(l).name;
                
                %partitionnement de l'ensemble d'apprentissage
                net.divideParam.trainRatio = PercentPartition(k)/100; 
                net.divideParam.valRatio = ((100-PercentPartition(k))/2)/100;   
                net.divideParam.testRatio = ((100-PercentPartition(k))/2)/100;  
                [trainV, valV, testV, trainInd, valInd, testInd] = dividerand(NNInPutNorm, net.divideParam.trainRatio, net.divideParam.valRatio, net.divideParam.testRatio);
                [trainT, valT, testT] = divideind(NNTarget, trainInd, valInd, testInd);

                %modification des parameteres 
                net.trainParam.epochs = 500; 
                net.trainParam.show = 50;
                net.trainParam.lr = 0.3; 
                net.trainParam.max_fail = 50;

                %appel de la fonction ntrain qui fait 10 fois
                %l'apprentissage du meme r�seau puis retoune le meilleur
                fprintf('Nombre de neurones : ')
                disp(NbNeurons(i))
                ntrain(net, NNInPutNorm, NNTarget, 10);
            end
        end
    end
end