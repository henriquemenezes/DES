function [ totalError, errors, result ] = LCA3( train, test, range, ensemble, numClassifiers, k, adaptiveWeights, withAKNN, combMethod )

[numTest, numCol] = size(test.data);
totalError = 0;
errors.data = [];
errors.labels = [];

h = waitbar(0,'LCA3...');

for testIndex = 1 : numTest
    waitbar(testIndex/numTest)
    testPr = dataset(test.data(testIndex,:), test.labels(testIndex,:)); % padr�o de teste i
    
    if allAgree(ensemble, testPr, numClassifiers), % verifica se todos tem a mesma sa�da
		temp = testc(testPr, ensemble{1}); % ent�o, usa o resultado do primeiro
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
            totalClassify2 = 0;
            totalCorrect2 = 0;
            
            for i = 1 : size(labelNearests, 1)
                if labelPr == labelClassifier(i),
                    totalClassify = totalClassify + 1;
                    if labelPr == labelNearests(i),
                        totalCorrect = totalCorrect + 1;
                    end;
                end;
                
                if labelPr == labelNearests(i),
                    totalClassify2 = totalClassify2 + 1;
                    if labelPr == labelClassifier(i),
                        totalCorrect2 = totalCorrect2 + 1;
                    end;
                end;
            end;
            
            accuracy1 = totalCorrect / totalClassify;
            accuracy2 = totalCorrect2 / totalClassify2;
            accuracy = (accuracy1 + accuracy2) / 2;
            
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

                tempDE_combMethod = tempDE * combMethod;

                labelPr = labeld(testPr, tempDE_combMethod);
                labelClassifier = labeld(nearestsDataset, tempDE_combMethod);
                labelNearests = nearestsDataset.labels;

                totalClassify = 0;
                totalCorrect = 0;
                totalClassify2 = 0;
                totalCorrect2 = 0;

                for idxNearest = 1 : size(labelNearests, 1)
                    if labelPr == labelClassifier(idxNearest),
                        totalClassify = totalClassify + 1;
                        if labelPr == labelNearests(idxNearest),
                            totalCorrect = totalCorrect + 1;
                        end;
                    end;
                    
                    if labelPr == labelNearests(idxNearest),
                        totalClassify2 = totalClassify2 + 1;
                        if labelPr == labelClassifier(idxNearest),
                            totalCorrect2 = totalCorrect2 + 1;
                        end;
                    end;
                end;

                accuracyEnsemble1 = totalCorrect / totalClassify;
                accuracyEnsemble2 = totalCorrect2 / totalClassify2;
                accuracyEnsemble = (accuracyEnsemble1 + accuracyEnsemble2) / 2;

                if accuracyEnsemble > currentAccuracy,
                    currentAccuracy = accuracyEnsemble;
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
fprintf('Error_LCA3 %f \n',(totalError/numTest) * 100);

close(h);

end
