% % DES - Dynamic Ensemble Selection                

% Classificadores
dstump = stumpc([]);              % decision stumps as weak classifiers
perceptron = perlc([]);           % perceptron as weak classifiers
dtree = treec([],'infcrit',0,-2); % decision trees classifer
quadratic = qdc([]);              % quadratic discriminant classifier
bayes = naivebc([]);              % naive bayes classifier
parzen = parzenc([]);             % parzen classifier
neural = lmnc([],5);              % neural classifier
knearests = knnc([],1);           % knn classifier
SVM = svc([],'p',2);              % SVM classifier
set(0, 'RecursionLimit', 15000);

% Classificador selecionado
classifier = perceptron;

combs = {votec};
strCombs = {'votec'};

for idx = 1 : size(combs, 2),
    
    combMethod = combs{idx}; %votec, meanc, prodc
    strComb = strCombs{idx};

    k = 1;

    withFA = false; % FA = Filter + Adaptive distance
    strFA = 'notFA';

    if withFA,
        strFA = 'withFA';
    end;

    filename = strcat('res\res_', strComb, '_k', num2str(k), '_', strFA, '.txt');

    outfile = fopen(filename, 'w');

    % % Standard
    scriptStart2('vehicle'     , withFA, k, quadratic , withFA, combMethod, outfile); % OK
    %scriptStart2('sonar'       , withFA, k, quadratic , withFA, combMethod, outfile); % OK
    %scriptStart2('ionosphere'  , withFA, k, quadratic , withFA, combMethod, outfile); % OK    
    scriptStart2('pima'        , withFA, k, classifier, withFA, combMethod, outfile); % OK
    scriptStart2('liver'       , withFA, k, classifier, withFA, combMethod, outfile); % OK
    scriptStart2('breast'      , withFA, k, classifier, withFA, combMethod, outfile); % OK    
    scriptStart2('blood'       , withFA, k, classifier, withFA, combMethod, outfile); % OK    
    scriptStart2('banana'      , withFA, k, classifier, withFA, combMethod, outfile); % OK    
    scriptStart2('lithuanian'  , withFA, k, classifier, withFA, combMethod, outfile); % OK

    fclose(outfile);

end;