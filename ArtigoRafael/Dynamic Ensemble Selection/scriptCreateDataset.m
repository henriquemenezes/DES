%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%LIVER

%surpress fucking prtools warning
prwarning(0); 
clear;

%define number of classifiers and number of nearests(k)
numClassifiers = 10;               %number of classifiers to generate
bagging = 0;                        %baggin ensemble                   
boosting = 1;                       %boosting ensemble 
randomSubspaces = 2;                %rss ensemble 

%liver
[trainDataset,validationDataset,testDataset,range] = initDataset('liver');

%getting the data to perform the nearestneighbor algorithm

train.data = getData(trainDataset);
train.labels = getlab(trainDataset);
validation.data = getData(validationDataset);
validation.labels = getlab(validationDataset);
test.data = getData(testDataset);
test.labels = getlab(testDataset);

adaptiveWeights = getAdaptiveWeights(validation.data,validation.labels,range);

%generate the ensemble
%method can be boosting, bagging or random subspaces
[ ensemble, adaboostCombination ] = generateEnsemble(trainDataset,numClassifiers,boosting,perlc([]));

save liver;
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%PIMA

%surpress fucking prtools warning
prwarning(0); 
clear;

%define number of classifiers and number of nearests(k)
numClassifiers = 10;               %number of classifiers to generate
bagging = 0;                        %baggin ensemble                   
boosting = 1;                       %boosting ensemble 
randomSubspaces = 2;                %rss ensemble 


[trainDataset,validationDataset,testDataset,range] = initDataset('pima');

%getting the data to perform the nearestneighbor algorithm

train.data = getData(trainDataset);
train.labels = getlab(trainDataset);
validation.data = getData(validationDataset);
validation.labels = getlab(validationDataset);
test.data = getData(testDataset);
test.labels = getlab(testDataset);

adaptiveWeights = getAdaptiveWeights(validation.data,validation.labels,range);

%generate the ensemble
%method can be boosting, bagging or random subspaces
[ ensemble, adaboostCombination ] = generateEnsemble(trainDataset,numClassifiers,boosting,perlc([]));

save pima;

