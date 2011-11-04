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
classifier = perceptron

% Saída: [meanVector, stdVector, processingTime, selectorPerformance] 
% Abreviações p/ Saída: [mv, sv, pT, sP]

% % ENN 1
% [mvVehicle, svVehicle, ptVehicle] = scriptStart2('vehicle', true , 1,quadratic,true);
% [mvSonar, svSonar, ptSonar] = scriptStart2('sonar', true , 1,classifier,true);
% [mvIonosphere, svIonosphere, ptIonosphere] = scriptStart2('ionosphere', true , 1,classifier,true);
% [mvPima, svPima, ptPima] = scriptStart2('pima', true , 1,classifier,true);
% [mvLiver, svLiver, ptLiver] = scriptStart2('liver', true , 1,classifier,true);
% [mvBreast, svBreast, ptBreast] = scriptStart2('breast', true , 1,classifier,true);
% [mvBlood, svBlood, ptBlood] = scriptStart2('blood', true , 1,classifier,true);
% [mvBanana, svBanana, ptBanana] = scriptStart2('banana', true , 1,classifier,true);
% [mvLithuanian, svLithuanian, ptLithuanian] = scriptStart2('lithuanian', true , 1,classifier,true);

% % ENN3
% [mvVehicle3, svVehicle3, ptVehicle3] = scriptStart2('vehicle', true , 3,quadratic,true);
% [mvSonar3, svSonar3, ptSonar3] = scriptStart2('sonar', true , 3,classifier,true);
% [mvIonosphere3, svIonosphere3, ptIonosphere3] = scriptStart2('ionosphere', true , 3,classifier,true);
% [mvPima3, svPima3, ptPima3] = scriptStart2('pima', true , 3,classifier,true);
% [mvLiver3, svLiver3, ptLiver3] = scriptStart2('liver', true , 3,classifier,true);
% [mvBreast3, svBreast3, ptBreast3] = scriptStart2('breast', true , 3,classifier,true);
% [mvBlood3, svBlood3, ptBlood3] = scriptStart2('blood', true , 3,classifier,true);
% [mvBanana3, svBanana3, ptBanana3] = scriptStart2('banana', true , 3,classifier,true);
% [mvLithuanian3, svLithuanian3, ptLithuanian3] = scriptStart2('lithuanian', true , 3,classifier,true);

% % ENN 5
% [mvVehicle5, svVehicle5, ptVehicle5] = scriptStart2('vehicle', true , 5,quadratic,true);
% [mvSonar5, svSonar5, ptSonar5] = scriptStart2('sonar', true , 5,classifier,true);
% [mvIonosphere5, svIonosphere5, ptIonosphere5] = scriptStart2('ionosphere', true , 5,classifier,true);
% [mvPima5, svPima5, ptPima5] = scriptStart2('pima', true , 5,classifier,true);
% [mvLiver5, svLiver5, ptLiver5] = scriptStart2('liver', true , 5,classifier,true);
% [mvBreast5, svBreast5, ptBreast5] = scriptStart2('breast', true , 5,classifier,true);
% [mvBlood5, svBlood5, ptBlood5] = scriptStart2('blood', true , 5,classifier,true);
% [mvBanana5, svBanana5, ptBanana5] = scriptStart2('banana', true , 5,classifier,true);
% [mvLithuanian5, svLithuanian5, ptLithuanian5] = scriptStart2('lithuanian', true , 5,classifier,true);

% % No ENN
% [mvVehicleN, svVehicleN, ptVehicleN] = scriptStart2('vehicle', false , 1,quadratic,true);
% [mvSonarN, svSonarN, ptSonarN] = scriptStart2('sonar', false , 1,classifier,true);
% [mvIonosphereN, svIonosphereN, ptIonosphereN] = scriptStart2('ionosphere', false , 1,classifier,true);
% [mvPimaN, svPimaN, ptPimaN] = scriptStart2('pima', false , 1,classifier,true);
% [mvLiverN, svLiverN, ptLiverN] = scriptStart2('liver', false , 1,classifier,true);
% [mvBreastN, svBreastN, ptBreastN] = scriptStart2('breast', false , 1,classifier,true);
% [mvBloodN, svBloodN, ptBloodN] = scriptStart2('blood', false , 1,classifier,true);
% [mvBananaN, svBananaN, ptBananaN] = scriptStart2('banana', false , 1,classifier,true);
% [mvLithuanianN, svLithuanianN, ptLithuanianN] = scriptStart2('lithuanian', false , 1,classifier,true);

% % Standard
[mvVehicleNormal, svVehicleNormal, ptVehicleNormal, spVehicle] = scriptStart2('vehicle', false , 1,quadratic,false);
[mvSonarNormal, svSonarNormal, ptSonarNormal, spSonar] = scriptStart2('sonar', false , 1,classifier,false);
[mvIonosphereNormal, svIonosphereNormal, ptIonosphereNormal, spIonosphere] = scriptStart2('ionosphere', false , 1,classifier,false);
[mvPimaNormal, svPimaNormal, ptPimaNormal, spPima] = scriptStart2('pima', false , 1,classifier,false);
[mvLiverNormal, svLiverNormal, ptLiverNormal, spLiver] = scriptStart2('liver', false , 1,classifier,false);
[mvBreastNormal, svBreastNormal, ptBreastNormal, spBreast] = scriptStart2('breast', false , 1,classifier,false);
[mvBloodNormal, svBloodNormal, ptBloodNormal, spBlood] = scriptStart2('blood', false , 1,classifier,false);
[mvBananaNormal, svBananaNormal, ptBananaNormal, spBanana] = scriptStart2('banana', false , 1,classifier,false);
[mvLithuanianNormal, svLithuanianNormal, ptLithuanianNormal, spLithuanian] = scriptStart2('lithuanian', false , 1,classifier,false);

% % Ultimos
% [mvSegmentation, svSegmentation, ptSegmentation] = scriptStart2('segmentation', true , 1,classifier,true);
% [mvSegmentation3, svSegmentation3, ptSegmentation3] = scriptStart2('segmentation', true , 3,classifier,true);
% [mvSegmentation5, svSegmentation5, ptSegmentation5] = scriptStart2('segmentation', true , 5,classifier,true);
% [mvOptDigit3, svOptDigit3, ptOptDigit3] = scriptStart2('optdigit', true , 3,classifier,true);
% [mvOptDigit5, svOptDigit5, ptOptDigit5] = scriptStart2('optdigit', true , 5,classifier,true);
% [mvOptDigitN, svOptDigitN, ptOptDigitN] = scriptStart2('optdigit', false , 1,classifier,true);
% [mvSegmentationN, svSegmentationN, ptSegmentationN] = scriptStart2('segmentation', false , 1,classifier,true);
% [mvOptDigit, svOptDigit, ptOptDigit] = scriptStart2('optdigit', true , 1,classifier,true);