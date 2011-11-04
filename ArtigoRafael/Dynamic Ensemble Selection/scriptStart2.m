function [meanVector, stdVector, processingTime, selectorPerformance] = scriptStart2(base, withENN , ennK, classifier, withAKNN)

% Variaveis para análise
processingTime = [];
resultsVector = [];

prwarning(0); % surpress prtools warning

for i = 1 : 3

% Define o número de classificadores e de vizinhos (k)
k = 7;                % Número (k) de vizinhos
numClassifiers = 10;  % Número de classificadores a serem gerados (ensemble)

% Métodos de geração de Ensemble
bagging = 0;          % Bagging ensemble
boosting = 1;         % Boosting ensemble 
randomSubspaces = 2;  % RSS ensemble 

[trainDataset, testDataset, validationDataset, range] = initDataset(base, withENN, ennK);

% % Pegando os dados de Treinamento, Validação e Teste
train.data = getdata(trainDataset);
train.labels = getlab(trainDataset);
validation.data = getdata(validationDataset);
validation.labels = getlab(validationDataset);
test.data = getdata(testDataset);
test.labels = getlab(testDataset);

adaptiveWeights = getAdaptiveWeights(validation.data, validation.labels);

% Gerando o Ensemble (Boosting, Bagging ou Random Subspaces)
[ensemble, adaboostCombination] = generateEnsemble(trainDataset, numClassifiers, bagging, classifier);

tic;

% KNORA-Eliminate
[totalError, error, results, selectorPerformance] = KNORAE(validation, test, range, ensemble, numClassifiers, k, adaptiveWeights, withAKNN);

% KNORA-Union
% [totalErrorKNORAU, results] = KNORAU(validation, test, range, ensemble, numClassifiers, k, adaptiveWeights, withAKNN);

% Variáveis para análise: Tempo de execução e resultado
processingTime = [processingTime toc];
resultsVector = [resultsVector results];

end;

meanVector = mean(resultsVector);
stdVector = std(resultsVector);
processingTime = mean(processingTime);

