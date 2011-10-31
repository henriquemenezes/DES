%Implements the KNORAE dynamic ensemble selection algorithm. 

function [ totalError, errors, result ] = KNORAEOutputs( validation, test, ensemble, numClassifiers, k )

[numTest,numCol] = size(test.data);

validationDataset = dataset(validation.data,validation.labels);

[ validationProfiles, hitAndMissValidation ] = outputProfiles( ensemble, validationDataset);

totalError = 0;
%for each test pattern

errors.data = [];
errors.labels = [];

h = waitbar(0,'KNORA-ELIMINATE OutProf');

for testIndex = 1 : numTest
 
    waitbar(testIndex/numTest)
    %testIndex
    %calculate the nearest neighbors
    testPr = dataset(test.data(testIndex,:),test.labels(testIndex,:));
    
    %get the output profiles for the validation
    [ profileTest, hitAndMissTest ] = outputProfiles( ensemble, testPr );
    
    %get the neighbors using output profiles
    [distances idx] = knnOutput(validationProfiles,profileTest);

    for nearestIndex = 1 : k

        nearests.data(nearestIndex,:) = validation.data( idx(:,nearestIndex), : );
        nearests.labels(nearestIndex,:) = validation.labels( idx(:,nearestIndex), : );

    end;

    nearestsDataset = dataset(nearests.data,nearests.labels);
    
    [dynamicEnsemble, selection] = selectEnsemble(nearestsDataset,ensemble,numClassifiers);
    
    comb = dynamicEnsemble * meanc;
    temp = testc(testPr,comb);
    
    if temp ~= 0,

        totalError = totalError + 1;
        errors.data = [ errors.data ; test.data(testIndex,:) ];
        errors.labels = [ errors.labels ; test.labels(testIndex,:) ];
      
    end;
    
end;
result = 100 - ( (totalError/numTest) * 100 );
fprintf('Test results result for KNORAE %f \n',(totalError/numTest) * 100);

close(h);
