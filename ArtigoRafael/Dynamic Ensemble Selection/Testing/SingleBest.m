%function used to get the performance of the best classifier of the
%ensemble
function [ totalError ] = SingleBest( ensemble, testDataset, numClassifier )

lowestError = 1;

for classifierIdx = 1 : numClassifier
    
        error = testc(testDataset,ensemble{classifierIdx});
        
        if error < lowestError
            
            lowestError = error;
                  
        end; %if
        
end; % for classifierIdx = 1 : numClassifier 
    
   
totalError = lowestError;    
fprintf('\n  Best Classifier %f', lowestError );