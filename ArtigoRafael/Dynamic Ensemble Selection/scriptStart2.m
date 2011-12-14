function [] = scriptStart2(base, withENN , ennK, classifier, withAKNN, combMethod, outfile)

fprintf('Database %s\n', base);
fprintf(outfile, strcat('database: [', base, ']\n'));

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
    [totalError, error, resultsKNORAE] = KNORAE(validation, test, range, ensemble, numClassifiers, k, adaptiveWeights, withAKNN, combMethod);
    fprintf(outfile, strcat('KNORAE(', num2str(resultsKNORAE), ', ', num2str(toc), ')\t'));
    
    tic;
    % OLA-DES
    [totalError, error, resultsOLA] = OLA(validation, test, range, ensemble, numClassifiers, k, adaptiveWeights, withAKNN, combMethod);
    fprintf(outfile, strcat('OLA(', num2str(resultsOLA), ', ', num2str(toc), ')\t'));
    
    tic;
    % LCA-DES
    [totalError, error, resultsLCA] = LCA(validation, test, range, ensemble, numClassifiers, k, adaptiveWeights, withAKNN, combMethod);
    fprintf(outfile, strcat('LCA(', num2str(resultsLCA), ', ', num2str(toc), ')\n'));
    
    %tic;
    % LCA2-DES
    %[totalError, error, resultsLCA2] = LCA2(validation, test, range, ensemble, numClassifiers, k, adaptiveWeights, withAKNN, combMethod);
    %fprintf(outfile, strcat('LCA2(', num2str(resultsLCA2), ', ', num2str(toc), ')\t'));
    
    %tic;
    % LCA3-DES
    %[totalError, error, resultsLCA3] = LCA3(validation, test, range, ensemble, numClassifiers, k, adaptiveWeights, withAKNN, combMethod);
    %fprintf(outfile, strcat('LCA3(', num2str(resultsLCA3), ', ', num2str(toc), ')\n'));
    
    % Variáveis para análise: Tempo de execução e resultado
    %processingTime = [processingTime toc];
    %resultsVector = [resultsVector results];
end;

meanVector = mean(resultsVector);
stdVector = std(resultsVector);
processingTime = mean(processingTime);

%fprintf('ProcessingTime %f\n', processingTime);