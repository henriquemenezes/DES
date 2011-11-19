function [ totalError, errors, result ] = OLA( train, test, range, ensemble, numClassifiers, k, adaptiveWeights, withAKNN, combMethod )

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

                tempDE_combMethod = tempDE * combMethod;
                error_tempDE_combMethod = testc(nearestsDataset, tempDE_combMethod);

                if error_tempDE_combMethod < currentError,
                    currentError = error_tempDE_combMethod;
                    dynamicEnsemble = tempDE;
                    dynamicEnsembleIdx = tempDEIdx;
                end;
            end;
        end;
        
        comb = dynamicEnsemble * combMethod;
        temp = testc(testPr, comb);
        
    end;
    
    if temp ~= 0,
        totalError = totalError + 1;
        errors.data = [ errors.data ; test.data(testIndex,:) ];
        errors.labels = [ errors.labels ; test.labels(testIndex,:) ];
    end;
end;

result = 100 - ( (totalError/numTest) * 100 );
fprintf('Error_OLA %f \n',(totalError/numTest) * 100);

close(h);

end