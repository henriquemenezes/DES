% Implements the KNORAE dynamic ensemble selection algorithm. 

function [ totalError, errors, result, selectorPerformance ] = KNORAE( train, test, range, ensemble, numClassifiers, k, adaptiveWeights,withAKNN  )

[numTest,numCol] = size(test.data);

totalError = 0;
%for each test pattern

errors.data = [];
errors.labels = [];

h = waitbar(0,'KNORA-ELIMINATE...');

for testIndex = 1 : numTest
 
    waitbar(testIndex/numTest)
    %testIndex
    %calculate the nearest neighbors
    
   
  testPr = dataset(test.data(testIndex,:),test.labels(testIndex,:));
  
  if allAgree(ensemble,testPr,numClassifiers),
        
        %if all classifiers have the same output, use the result of the
        %first
        temp = testc(testPr,ensemble{1});
    
  else

    if withAKNN,
         [nearests.data,distances,idx] = aknn(train.data,test.data(testIndex,:),range,k,adaptiveWeights);
    else
        [nearests.data,distances,idx] = knn(train.data,test.data(testIndex,:),range,k);
    end;
                 
       for nearestIndex = 1 : k

            nearests.labels(nearestIndex,:) = train.labels( idx(:,nearestIndex), : );

        end;

        nearestsDataset = dataset(nearests.data,nearests.labels);
       [dynamicEnsemble, selection, correct] = selectEnsemble(nearestsDataset,ensemble,numClassifiers,testPr);

        comb = dynamicEnsemble * votec;
        temp = testc(testPr,comb);
  end;
    
    if temp ~= 0,

        totalError = totalError + 1;
        errors.data = [ errors.data ; test.data(testIndex,:) ];
        errors.labels = [ errors.labels ; test.labels(testIndex,:) ];
      
    end;
    
end;

selectorPerformance = (correct/(numTest * numClassifiers)) * 100;

result = 100 - ( (totalError/numTest) * 100 );
fprintf('Test results result for KNORAE %f \n',(totalError/numTest) * 100);

close(h);
