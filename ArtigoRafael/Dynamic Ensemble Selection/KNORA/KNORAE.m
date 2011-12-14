% Implements the KNORAE dynamic ensemble selection algorithm. 
function [ totalError, errors, result ] = KNORAE( train, test, range, ensemble, numClassifiers, k, adaptiveWeights, withAKNN, combMethod )

[numTest, numCol] = size(test.data);
totalError = 0;
errors.data = [];
errors.labels = [];

h = waitbar(0,'KNORA-ELIMINATE...');

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
		
		[dynamicEnsemble, selection, correct] = selectEnsemble(nearestsDataset, ensemble, numClassifiers, testPr);

        comb = dynamicEnsemble * combMethod;
        temp = testc(testPr, comb);
	end;
    
    if temp ~= 0,
        totalError = totalError + 1;
        errors.data = [ errors.data ; test.data(testIndex,:) ];
        errors.labels = [ errors.labels ; test.labels(testIndex,:) ];
    end;
end;

%selectorPerformance = (correct/(numTest * numClassifiers)) * 100;

result = 100 - ( (totalError/numTest) * 100 );
fprintf('Error_KNORAE %f \n',(totalError/numTest) * 100);

close(h);