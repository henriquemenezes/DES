function [ outputDataset ] = enn( inputDataset, k )

    [numInstances, numFeatures] = size(inputDataset.data);
    classifier = knnc([],k);
    
    outputDataset.data = inputDataset.data;
    outputDataset.labels = inputDataset.labels;
    removedElements = [];
    
    for instanceIndex = 1 : numInstances,
        
        tempDataset.data = inputDataset.data;
        tempDataset.labels = inputDataset.labels;
        
        tempDataset.data(instanceIndex,:) = []; 
        tempDataset.labels(instanceIndex,:) = [] ;
  
        tempDataset = dataset(tempDataset.data, tempDataset.labels);
        
        %classifier mapping
        nnclassifier = tempDataset * classifier;
            
        testPr = dataset( inputDataset.data(instanceIndex,:),inputDataset.labels(instanceIndex) );
        result = testc(testPr,nnclassifier);
        
        if result ~=0,
            removedElements = [removedElements instanceIndex];
        end;
                
        tempDataset = [];
        
    end;
    
    [aaa numElements] = size(removedElements);
    
    for i = 0 : numElements - 1
        outputDataset.data(removedElements(numElements-i),:) = [];
        outputDataset.labels(removedElements(numElements-i)) = [];
    end;
    outputDataset = dataset(outputDataset.data,outputDataset.labels);
    