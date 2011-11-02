%Funcion used to calculate the oracle (perfect combination) performance of
%the ensemble.
function [ totalError ] = oracle( ensemble, testDataset, numClassifier )

[testNumber aa] = size(testDataset.data);
totalError = 0;


for testIdx = 1 : testNumber

    testPr = dataset(testDataset.data(testIdx,:),testDataset.labels(testIdx,:));
    misclassified = 1;

    for classifierIdx = 1 : numClassifier
    
        error = testc(testPr,ensemble{classifierIdx});
        
        if error == 0
            misclassified = 0;
            break;
        
        end; %if
        
    end; % for classifierIdx = 1 : numClassifier 
    
     totalError = totalError + misclassified;
    
end; % for testIdx = 1 : testNumber
    
fprintf('\n  Test results result for ORACLE %f',(totalError/testNumber));

totalError = (1 - (totalError/testNumber)) * 100;