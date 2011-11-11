function [ totalError, errors, result ] = LCA( train, test, range, ensemble, numClassifiers, k, adaptiveWeights, withAKNN )

[numTest, numCol] = size(test.data);
totalError = 0;
errors.data = [];
errors.labels = [];

h = waitbar(0,'LCA...');

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
        classAccuracy = [];
        
        for classifierIdx = 1 : numClassifiers
            labelPr = labeld(testPr, ensemble{classifierIdx});
            labelClassifier = labeld(nearestsDataset, ensemble{classifierIdx});
            labelNearests = nearestsDataset.labels;
            
            totalClassify = 0;
            totalCorrect = 0;
            
            for i = 1 : size(labelNearests, 1)
                if labelPr == labelClassifier(i),
                    totalClassify = totalClassify + 1;
                    if labelPr == labelNearests(i),
                        totalCorrect = totalCorrect + 1;
                    end;
                end;
            end;
            
            accuracy = totalCorrect / totalClassify;
            
            classAccuracy = [classAccuracy accuracy];
        end;
        
        [classAccuracy, rankIdx] = sort(classAccuracy, 'descend');
        
        dynamicEnsemble = [];
        dynamicEnsembleIdx = [];
        
        dynamicEnsemble = [dynamicEnsemble ensemble{rankIdx(1)}];
        dynamicEnsembleIdx = [dynamicEnsembleIdx rankIdx(1)];
        
        currentAccuracy = classAccuracy(1);
        
        if currentAccuracy < 1,
            for i = 2 : numClassifiers
                tempDE = [dynamicEnsemble ensemble{rankIdx(i)}];
                tempDEIdx = [dynamicEnsembleIdx rankIdx(i)];

                tempDE_Votec = tempDE * votec;

                labelPr = labeld(testPr, tempDE_Votec);
                labelClassifier = labeld(nearestsDataset, tempDE_Votec);
                labelNearests = nearestsDataset.labels;

                totalClassify = 0;
                totalCorrect = 0;

                for idxNearest = 1 : size(labelNearests, 1)
                    if labelPr == labelClassifier(idxNearest),
                        totalClassify = totalClassify + 1;
                        if labelPr == labelNearests(idxNearest),
                            totalCorrect = totalCorrect + 1;
                        end;
                    end;
                end;

                accuracyEnsemble = totalCorrect / totalClassify;

                if accuracyEnsemble > currentAccuracy,
                    currentAccuracy = accuracyEnsemble;
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
fprintf('Test results result for LCA %f \n',(totalError/numTest) * 100);

close(h);