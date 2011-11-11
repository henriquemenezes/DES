function [ totalError, errors, result ] = OLA( train, test, range, ensemble, numClassifiers, k, adaptiveWeights, withAKNN )

[numTest, numCol] = size(test.data);
totalError = 0;
errors.data = [];
errors.labels = [];

h = waitbar(0,'OLA...');

for testIndex = 1 : numTest
    waitbar(testIndex/numTest)
    testPr = dataset(test.data(testIndex,:), test.labels(testIndex,:)); % padrão de teste i
    
    if allAgree(ensemble, testPr, numClassifiers), % verifica se todos tem a mesma saída
		temp = testc(testPr, ensemble{1}); % então, usa o resultado do primeiro
    else
        if withAKNN,
			[nearests.data, distances, idx] = aknn(train.data, test.data(testIndex,:), range, k, adaptiveWeights);
		else
			[nearests.data, distances, idx] = knn(train.data, test.data(testIndex,:), range, k);
		end;
        
        for nearestIndex = 1 : k
			nearests.labels(nearestIndex,:) = train.labels( idx(:,nearestIndex), : );
        end;
        
        nearestsDataset = dataset(nearests.data, nearests.labels);
        classifierError = [];
        
        for classifierIdx = 1 : numClassifiers
            errorIdx = testc(nearestsDataset, ensemble{classifierIdx});
            classifierError = [classifierError errorIdx];
        end;
        
        [classifierError, rankIdx] = sort(classifierError, 'ascend');
        
        dynamicEnsemble = [];
        dynamicEnsembleIdx = [];
        
        dynamicEnsemble = [dynamicEnsemble ensemble{rankIdx(1)}];
        dynamicEnsembleIdx = [dynamicEnsembleIdx rankIdx(1)];
        
        currentError = classifierError(1);
        
        if currentError > 0,
            for i = 2 : numClassifiers
                tempDE = [dynamicEnsemble ensemble{rankIdx(i)}];
                tempDEIdx = [dynamicEnsembleIdx rankIdx(i)];

                tempDE_Votec = tempDE * votec;
                error_tempDE_Votec = testc(nearestsDataset, tempDE_Votec);

                if error_tempDE_Votec < currentError,
                    currentError = error_tempDE_Votec;
                    dynamicEnsemble = tempDE;
                    dynamicEnsembleIdx = tempDEIdx;
                end;
            end;
        end;
        
        comb = dynamicEnsemble * votec;
        temp = testc(testPr, comb);
        
    end;
    
    if temp ~= 0,
        totalError = totalError + 1;
        errors.data = [ errors.data ; test.data(testIndex,:) ];
        errors.labels = [ errors.labels ; test.labels(testIndex,:) ];
    end;
end;

result = 100 - ( (totalError/numTest) * 100 );
fprintf('Test results result for OLA %f \n',(totalError/numTest) * 100);

close(h);
% para cada padrão de teste
    % filter
    % % para cada classificador do ensemble
    % % % avalia de acordo com os k-vizinhos do padrão de teste
    % % faz o ranking dos classificadores do ensemble de acordo com a
    % % precisão
    % wrapper
    % % inicializa um subconjunto com o primeiro do ranking
    % % avalia os k-vizinhos e armazena em uma variável
    % % para cada elemento do ranking (a partir do 2º)
    % % % adiciona o classificador no subconjunto temporário
    % % % avalia os k-vizinhos e verifica se foi maior que o anterior
    % % % se for maior
    % % % % adiciona no subconjunto