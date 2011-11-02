%This function computes the leave one out error using knn ont the specified dataset.
function [ error ] = leaveOneOut( dataset )

[trainDataset,validationDataset,testDataset,range,data] = initDataset(dataset,false ,1);

error = [];

%i = 1;

%while i <= 15
    
    [ERR,CERR,NLAB_OUT] = crossval(data,knnc([],7),[]);

    error = [error (ERR * 100)];
    
   % i = i  + 2;
    
%end;