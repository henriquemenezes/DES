
function [ weights ] = getWeights( nearestsDataset, ensemble, numClassifiers  )
    
 k = nearestsDataset.objsize;
 [a numClassifiers2] = size(ensemble.data);
 weights = zeros(1,numClassifiers2);
  
 for classifierIdx = 1 : numClassifiers
     if numClassifiers2 > numClassifiers,
           
           if classifierIdx == 1,
               
               num = numClassifiers2-numClassifiers;
               [error,number] = testc(nearestsDataset,stacked(ensemble.data(1:num+1)));
               weights(1,1:classifierIdx+num) = k - sum(number);
           
           else
               [error, number] = testc(nearestsDataset,ensemble{classifierIdx + num});
               weights(1,classifierIdx + num) = k - sum(number);
           end;
     else
               [error, number] = testc(nearestsDataset,ensemble{classifierIdx});
              weights(1,classifierIdx) = k - sum(number);
     end;

       %weights(1,classifierIdx) = k - sum(number);
                 
 end;
     
 