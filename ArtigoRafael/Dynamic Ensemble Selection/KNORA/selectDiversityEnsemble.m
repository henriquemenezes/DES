%selects the N most diverses classifiers to create the ensemble.

function [ dynamicEnsemble, selection, diversity ] = selectDiversityEnsemble( nearestsDataset, ensemble, numClassifiers, k )

 diversity = zeros(1,numClassifiers); 
 dynamicEnsemble = [];
 selection = zeros(1,numClassifiers);
 
for classifierA = 1 : numClassifiers
     
     %compute diversity of each classifier (A) in relation to the others
     %(Classifier B)
     for classifierB = 1 : numClassifiers
     
         %for each nearest sample
         for nearestsIdx = 1 : k
             
               testPr = dataset(nearestsDataset.data(nearestsIdx,:),nearestsDataset.labels(nearestsIdx,:));
               
               posterioriClassifierA = testPr * ensemble{classifierA} * classc;
               posterioriClassifierB = testPr * ensemble{classifierB} * classc;
               
               %squared difference between classifier outputs as diversty
               diversity(1,classifierA) = diversity(1,classifierA) + sum( (posterioriClassifierA.data - posterioriClassifierB.data).^2 );
               
               
         end;
         
     end;
     
 end;

 [diversity idx] = sort(diversity, 'descend');
 
  for i = 1 : 4
      
      dynamicEnsemble = [dynamicEnsemble ensemble{ idx(i) } ];
      selection( idx(i) ) = 1;
          
  end;