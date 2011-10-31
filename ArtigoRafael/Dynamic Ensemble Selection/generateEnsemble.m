%Function used to generate the ensemble. The ensemble can be generated
%using either Adaboost or Bagging. The vector combined has the weights
%values according when the method Adaboost is used (Weights according to
%adaboost combination)

function [ensemble,combined] = generateEnsemble( data, numClassifiers, method, weakClassifier )

%method
%adaboost = 1
%bagging = 0

combined = [];                   %used for adaboost combination rule                 %

%creating a prtools dataset and splitting into train (70%) and test (30%)
%[prTrain,prTest] = gendat(data,0.5);

%Using the passed weak classifiers
if method == 0,
    ensemble = baggingc(data,weakClassifier,numClassifiers,[],[]);
elseif method == 1,
    [combined,ensemble,alf] = adaboostc(data,weakClassifier,numClassifiers);%,[],[]);
    
else
    ensemble = rsscc(data,weakClassifier,4,numClassifiers);
end;


