tempo = [];
%surpress fucking prtools warning
prwarning(0);
for i = 1 : 5
%clear;

%define number of classifiers and number of nearests(k)
% 
% 
k = 7;                             %number of nearests
numClassifiers = 10;               %number of classifiers to generate
bagging = 0;                        %baggin ensemble                   
boosting = 1;                       %boosting ensemble 
randomSubspaces = 2;                %rss ensemble 

%classifiers
dstump = stumpc([]);            %decision stumps as weak classifiers
perceptron = perlc([]);         %perceptron as weak classifiers
dtree = treec([],'infcrit',0);      %decision trees classifer
quadratic = qdc([]);            %quadratic discriminant classifier
bayes = naivebc([]);            %naive bayes classifier
parzen = parzenc([]);           %parzen classifier
knearests = knnc([],1);

[trainDataset, testDataset, validationDataset,range] = initDataset('banana',false,1);

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
     [ ensemble, adaboostCombination ] = generateEnsemble(trainDataset,numClassifiers,bagging,perceptron);
%tic;
     %The KNORA-Eliminate combination scheme
     [ totalError, error, results ] = KNORAE( validation, test, range , ensemble, numClassifiers, k, adaptiveWeights, false  );
%tempo = [tempo toc];
     %The KNORA-E Using Output profiles
    % [ totalError, errors, results ] = KNORAEOutputs( validation, test, ensemble, numClassifiers, k );

%     errors =[errors results];
    % [totalErrorKNORAU accuracy]  = KNORAU( validation, test, range , ensemble, numClassifiers, k, adaptiveWeights,(threshold/100)  );
     
%     for threshold = 60 : 90 
%     %The KNORA-Union combination scheme
%        % [totalErrorKNORAU accuracy]  = KNORAUConfidence( validation, test, range , ensemble, numClassifiers, k, adaptiveWeights,(threshold/100)  );
%        [totalErrorKNORAU accuracy]  = KNORAUConfidenceNN( validation, test, range , ensemble, numClassifiers, k, adaptiveWeights,(threshold/100)  );
%         accuracyVector = [accuracyVector accuracy];
%         thresholdVector = [thresholdVector (threshold/100)];
%    
%     end;
    %[ output_args ] = kdiversity( validation, test, range, ensemble, numClassifiers, k, adaptiveWeights );

    % 
    % %The KNORA-Eliminate_Weighted combination scheme
    % totalError = KNORAEW( train, test, range , ensemble, numClassifiers, k  );
    % 
    % %The KNORA-Eliminate combination scheme
    % totalError = KNORAUW( train, test, range , ensemble, numClassifiers, k  );
end;
