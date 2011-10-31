function [ dynamicEnsemble, histSelection, correct ] = selectEnsemble( nearestsDataset, ensemble, numClassifiers, testPr )

  done = false;
  number = 0;
  selectedIdx = [];
  correct = 0;
  
  [a numClassifiers2] = size(ensemble.data);
  
  while ~done,
     
     dynamicEnsemble = [];
     histSelection = zeros(1,numClassifiers);

    if nearestsDataset.objsize < 1,
           
          done = true;
          dynamicEnsemble = ensemble;
           break;
    end;
    
    for classifierIdx = 1 : numClassifiers
       multiclassProblem = false;
       
       if numClassifiers2 > numClassifiers,
           
           if classifierIdx == 1,
               
               num = numClassifiers2-numClassifiers;
               error = testc(nearestsDataset,stacked(ensemble.data(1:num+1)));
               multiclassProblem = true;
           else
                error = testc(nearestsDataset,ensemble{classifierIdx + num});
           end; 
       
       else %classifierIdx == 1,
        
        error = testc(nearestsDataset,ensemble{classifierIdx});
       
       end; %numClassifiers2 > numClassifiers,
       
        if error == 0,
            
            if numClassifiers2 > numClassifiers, 
            
                if multiclassProblem,

                    histSelection(1,classifierIdx) = 1;
                    dynamicEnsemble = [dynamicEnsemble stacked(ensemble.data(1:num+1))];
                    selectedIdx = [selectedIdx classifierIdx];

                else
                    histSelection(1,classifierIdx) = 1;
                    dynamicEnsemble = [dynamicEnsemble ensemble{classifierIdx+num}];
                    selectedIdx = [selectedIdx classifierIdx];
                end;
                
            else
                histSelection(1,classifierIdx) = 1;
                dynamicEnsemble = [dynamicEnsemble ensemble{classifierIdx}];
                selectedIdx = [selectedIdx classifierIdx];

            end;

        end;
           
    end;
     
     if size(dynamicEnsemble) > 0,
    
         done = true;                   %found the ensemble
    
     else
         [numberObjects,numberFeatures,numberClasses] = getsize(nearestsDataset);
         
         %decrease nearests neighbor number number
         nearestsDataset.data = nearestsDataset.data(1:numberObjects-1,:); 
         nearestsDataset.nlab = nearestsDataset.nlab(1:numberObjects-1,:);
         nearestsDataset.objsize = nearestsDataset.objsize - 1;
        % numberObjects
    
     end;
 
  end;
  
  for i = 1 : numClassifiers
      selectorError = testc(testPr,ensemble{classifierIdx});
      temp = find(selectedIdx == i);
      if temp,
          %was selected
          if selectorError == 0,
            correct = correct + 1;
          end;
              
      else
          %was not select
          if selectorError ~= 0,
            correct = correct + 1;
          end; %otherwise error (no need to be computed)
      end;
      
  end;
  