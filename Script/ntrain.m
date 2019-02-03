function [bestTrPerf, bestTrRegress, bestTr, bestNet, Output] = ntrain(net, NNInPut, NNTarget1, n)

            %******************************* Premiere it�ration *******************************%
			%lancer l'apprentissage
    		[net, tr] = train(net, NNInPut, NNTarget1);
			
			%calculer la regression
			[r,~,~] = regression(NNTarget1, net(NNInPut));
			
			%sauvegarder le r�seau et sa trace (the first one)
			bestTrPerf = tr.best_perf;
			bestTr = tr;
			bestNet = net;
			bestTrRegress = mean(r);
			
			%Simuler le r�seau (net) en NNInPut (resultat mis dans Output)
			%Error = NNTarget1 - bestNet(NNInPut);
            %fprintf('errors = %f\n',Error);
            
			%Initialisation des totals
			totalPerf = tr.best_vperf; %validation performance
			totalEpochs = tr.best_epoch;
			totalReg = mean(r);
			
            %******************************* Les n-1 it�rations restantes *******************************%
            
		for i = 1 : 1 : n-1
			net = init(net);
			[net, tr] = train(net, NNInPut, NNTarget1);
			[r,~,~] = regression(NNTarget1, net(NNInPut));
			totalPerf = totalPerf + tr.best_vperf;
			totalEpochs = totalEpochs + tr.best_epoch;
			totalReg = totalReg + mean(r);
			
			if tr.best_perf<bestTrPerf && mean(r)>bestTrRegress
				bestTrPerf = tr.best_perf;
				bestTrRegress = mean(r);
				bestNet = net;
				bestTr = tr;
				Output = bestNet(NNInPut); %simulation du r�seaux
			end
		end
		       
		fprintf('Best performance achieved :')
		disp(bestTrPerf)
		
		fprintf('Best regression achieved :')
		disp(bestTrRegress)
				
		%Visualisation l'architecture du meilleur reseau de neurone parmi
		%les 10 test�s
			%view(bestNet);
            %courbe de regression
			plotregression(NNTarget1,Output)
            %Courbe de performance
			plotperform(bestTr)
            %Error = NNTarget1 - Output; %output est calcul� dans la boucle
            %fprintf('errors = %f\n',Error);