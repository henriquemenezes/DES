% Faz a seleção do ensemble para o KNORAE, dados o padrão de teste, os k-vizinhos, 
% o ensemble inicial e o total de classificadores do ensemble inicial.
%
% Entradas:
% - nearestsDataset: dataset dos k-vizinhos do conjunto de treinamento do padrão de teste
% - ensemble: conjunto inicial de classificadores
% - numClassifiers: total de classificadores do conjunto inicial (ensemble)
% - testPr: padrão de teste (query)

function [ dynamicEnsemble, histSelection, correct ] = selectEnsemble( nearestsDataset, ensemble, numClassifiers, testPr )

done = false;
selectedIdx = [];
correct = 0;

[a numClassifiers2] = size(ensemble.data);
  
while ~done,
	dynamicEnsemble = [];
	histSelection = zeros(1, numClassifiers);

	% Se não existe mais vizinho do padrão de teste, parar.
	if nearestsDataset.objsize < 1,
		done = true;
		dynamicEnsemble = ensemble;
		break;
	end;
    
	% Para cada classificador do ensemble inicial
	for classifierIdx = 1 : numClassifiers
		multiclassProblem = false;

		% Faz o teste do classificador com os k-vizinhos
		if numClassifiers2 > numClassifiers,
			if classifierIdx == 1,
				num = numClassifiers2 - numClassifiers;
				error = testc(nearestsDataset, stacked(ensemble.data(1:num+1)));
				multiclassProblem = true;
			else
				error = testc(nearestsDataset, ensemble{classifierIdx + num});
			end;        
		else % Usa os classificadores do ensemble individualmente para testar
			error = testc(nearestsDataset, ensemble{classifierIdx});		   
		end; %numClassifiers2 > numClassifiers,

		% Verifica se o classificador classificou corretamente todos os k-vizinhos
		if error == 0,            
			if numClassifiers2 > numClassifiers,             
				if multiclassProblem,
					% Marca que o classificador Idx foi selecionado histSelection(Idx) = 1
					histSelection(1, classifierIdx) = 1;
					% Coloca o classificadores até Idx combinado no vetor dynamicEnsemble
					dynamicEnsemble = [dynamicEnsemble stacked(ensemble.data(1:num+1))];
					% Armazena o índice (Idx) do classificador selecionado no vetor selectedIdx
					selectedIdx = [selectedIdx classifierIdx];
				else
					% Marca que o classificador Idx foi selecionado histSelection(Idx) = 1
					histSelection(1, classifierIdx) = 1;
					% Coloca o classificadores até Idx combinado no vetor dynamicEnsemble
					dynamicEnsemble = [dynamicEnsemble ensemble{classifierIdx+num}];
					% Armazena o índice (Idx) do classificador selecionado no vetor selectedIdx
					selectedIdx = [selectedIdx classifierIdx];
				end;                
			else
				% Marca que o classificador Idx foi selecionado histSelection(Idx) = 1
				histSelection(1, classifierIdx) = 1; 
				% Coloca o classificador Idx selecionado no vetor dynamicEnsemble
				dynamicEnsemble = [dynamicEnsemble ensemble{classifierIdx}];
				% Armazena o índice (Idx) do classificador selecionado no vetor selectedIdx
				selectedIdx = [selectedIdx classifierIdx];
			end;
		end;
	end;
     
	if size(dynamicEnsemble) > 0,
		done = true; % Ensemble encontrado
	else
		[numberObjects, numberFeatures, numberClasses] = getsize(nearestsDataset);
		% diminui 1 vizinho mais proximo
		nearestsDataset.data = nearestsDataset.data(1:numberObjects-1,:); 
		nearestsDataset.nlab = nearestsDataset.nlab(1:numberObjects-1,:);
		nearestsDataset.objsize = nearestsDataset.objsize - 1;
	end;
end;

for i = 1 : numClassifiers
	selectorError = testc(testPr, ensemble{i});
	temp = find(selectedIdx == i);
	if temp,
		%was selected
		if selectorError == 0,
			correct = correct + 1;
		end;    
	else
		%was not select
		if selectorError ~= 0,
			correct = correct + 1;
		end; %otherwise error (no need to be computed)
	end;
end;