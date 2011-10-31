dstump = stumpc([]);            %decision stumps as weak classifiers
perceptron = perlc([]);         %perceptron as weak classifiers
dtree = treec([],'infcrit',0,-2);      %decision trees classifer
quadratic = qdc([]);            %quadratic discriminant classifier
bayes = naivebc([]);            %naive bayes classifier
parzen = parzenc([]);           %parzen classifier
neural = lmnc([],5);
knearests = knnc([],1);
SVM = svc([],'p',2);
set(0,'RecursionLimit',15000);

classifier = perceptron

% %ENN 1
% [meanVectorVehicle, stdVectorVehicle, processingTimeVehicle] = scriptStart2('vehicle', true , 1,quadratic,true);
% [meanVectorSonar, stdVectorSonar, processingTimeSonar] = scriptStart2('sonar', true , 1,classifier,true);
% [meanVectorIonosphere, stdVectorIonosphere, processingTimeIonosphere] = scriptStart2('ionosphere', true , 1,classifier,true);
% [meanVectorPima, stdVectorPima, processingTimePima] = scriptStart2('pima', true , 1,classifier,true);
% [meanVectorLiver, stdVectorLiver, processingTimeLiver] = scriptStart2('liver', true , 1,classifier,true);
% [meanVectorBreast, stdVectorBreast, processingTimeBreast] = scriptStart2('breast', true , 1,classifier,true);
% [meanVectorBlood, stdVectorBlood, processingTimeBlood] = scriptStart2('blood', true , 1,classifier,true);
% [meanVectorBanana, stdVectorBanana, processingTimeBanana] = scriptStart2('banana', true , 1,classifier,true);
% [meanVectorLithuanian, stdVectorLithuanian, processingTimeLithuanian] = scriptStart2('lithuanian', true , 1,classifier,true);
% % %ENN3
% [meanVectorVehicle3, stdVectorVehicle3, processingTimeVehicle3] = scriptStart2('vehicle', true , 3,quadratic,true);
% [meanVectorSonar3, stdVectorSonar3, processingTimeSonar3] = scriptStart2('sonar', true , 3,classifier,true);
% [meanVectorIonosphere3, stdVectorIonosphere3, processingTimeIonosphere3] = scriptStart2('ionosphere', true , 3,classifier,true);
% [meanVectorPima3, stdVectorPima3, processingTimePima3] = scriptStart2('pima', true , 3,classifier,true);
% [meanVectorLiver3, stdVectorLiver3, processingTimeLiver3] = scriptStart2('liver', true , 3,classifier,true);
% [meanVectorBreast3, stdVectorBreast3, processingTimeBreast3] = scriptStart2('breast', true , 3,classifier,true);
% [meanVectorBlood3, stdVectorBlood3, processingTimeBlood3] = scriptStart2('blood', true , 3,classifier,true);
% [meanVectorBanana3, stdVectorBanana3, processingTimeBanana3] = scriptStart2('banana', true , 3,classifier,true);
% [meanVectorLithuanian3, stdVectorLithuanian3, processingTimeLithuanian3] = scriptStart2('lithuanian', true , 3,classifier,true);
% % %ENN 5
% [meanVectorVehicle5, stdVectorVehicle5, processingTimeVehicle5] = scriptStart2('vehicle', true , 5,quadratic,true);
% [meanVectorSonar5, stdVectorSonar5, processingTimeSonar5] = scriptStart2('sonar', true , 5,classifier,true);
% [meanVectorIonosphere5, stdVectorIonosphere5, processingTimeIonosphere5] = scriptStart2('ionosphere', true , 5,classifier,true);
% [meanVectorPima5, stdVectorPima5, processingTimePima5] = scriptStart2('pima', true , 5,classifier,true);
% [meanVectorLiver5, stdVectorLiver5, processingTimeLiver5] = scriptStart2('liver', true , 5,classifier,true);
% [meanVectorBreast5, stdVectorBreast5, processingTimeBreast5] = scriptStart2('breast', true , 5,classifier,true);
% [meanVectorBlood5, stdVectorBlood5, processingTimeBlood5] = scriptStart2('blood', true , 5,classifier,true);
% [meanVectorBanana5, stdVectorBanana5, processingTimeBanana5] = scriptStart2('banana', true , 5,classifier,true);
% [meanVectorLithuanian5, stdVectorLithuanian5, processingTimeLithuanian5] = scriptStart2('lithuanian', true , 5,classifier,true);
% % %no ENN
% [meanVectorVehicleN, stdVectorVehicleN, processingTimeVehicleN] = scriptStart2('vehicle', false , 1,quadratic,true);
% [meanVectorSonarN, stdVectorSonarN, processingTimeSonarN] = scriptStart2('sonar', false , 1,classifier,true);
% [meanVectorIonosphereN, stdVectorIonosphereN, processingTimeIonosphereN] = scriptStart2('ionosphere', false , 1,classifier,true);
% [meanVectorPimaN, stdVectorPimaN, processingTimePimaN] = scriptStart2('pima', false , 1,classifier,true);
% [meanVectorLiverN, stdVectorLiverN, processingTimeLiverN] = scriptStart2('liver', false , 1,classifier,true);
% [meanVectorBreastN, stdVectorBreastN, processingTimeBreastN] = scriptStart2('breast', false , 1,classifier,true);
% [meanVectorBloodN, stdVectorBloodN, processingTimeBloodN] = scriptStart2('blood', false , 1,classifier,true);
% [meanVectorBananaN, stdVectorBananaN, processingTimeBananaN] = scriptStart2('banana', false , 1,classifier,true);
% [meanVectorLithuanianN, stdVectorLithuanianN, processingTimeLithuanianN] = scriptStart2('lithuanian', false , 1,classifier,true);
% %Standard
[meanVectorVehicleNormal, stdVectorVehicleNormal, processingTimeVehicleNormal, selectorPerformanceVehicle] = scriptStart2('vehicle', false , 1,quadratic,false);
[meanVectorSonarNormal, stdVectorSonarNormal, processingTimeSonarNormal, selectorPerformanceSonar] = scriptStart2('sonar', false , 1,classifier,false);
[meanVectorIonosphereNormal, stdVectorIonosphereNormal, processingTimeIonosphereNormal, selectorPerformanceIonosphere] = scriptStart2('ionosphere', false , 1,classifier,false);
[meanVectorPimaNormal, stdVectorPimaNormal, processingTimePimaNormal, selectorPerformancePima] = scriptStart2('pima', false , 1,classifier,false);
[meanVectorLiverNormal, stdVectorLiverNormal, processingTimeLiverNormal, selectorPerformanceLiver] = scriptStart2('liver', false , 1,classifier,false);
[meanVectorBreastNormal, stdVectorBreastNormal, processingTimeBreastNormal, selectorPerformanceBreast] = scriptStart2('breast', false , 1,classifier,false);
[meanVectorBloodNormal, stdVectorBloodNormal, processingTimeBloodNormal, selectorPerformanceBlood] = scriptStart2('blood', false , 1,classifier,false);
[meanVectorBananaNormal, stdVectorBananaNormal, processingTimeBananaNormal, selectorPerformanceBanana] = scriptStart2('banana', false , 1,classifier,false);
[meanVectorLithuanianNormal, stdVectorLithuanianNormal, processingTimeLithuanianNormal, selectorPerformanceLithuanian] = scriptStart2('lithuanian', false , 1,classifier,false);

% ultimos
% [meanVectorSegmentation, stdVectorSegmentation, processingTimeSegmentation] = scriptStart2('segmentation', true , 1,classifier,true);
% [meanVectorSegmentation3, stdVectorSegmentation3, processingTimeSegmentation3] = scriptStart2('segmentation', true , 3,classifier,true);
% [meanVectorSegmentation5, stdVectorSegmentation5, processingTimeSegmentation5] = scriptStart2('segmentation', true , 5,classifier,true);
% [meanVectorOptDigit3, stdVectorOptDigit3, processingTimeOptDigit3] = scriptStart2('optdigit', true , 3,classifier,true);
% [meanVectorOptDigit5, stdVectorOptDigit5, processingTimeOptDigit5] = scriptStart2('optdigit', true , 5,classifier,true);
% [meanVectorOptDigitN, stdVectorOptDigitN, processingTimeOptDigitN] = scriptStart2('optdigit', false , 1,classifier,true);
% [meanVectorSegmentationN, stdVectorSegmentationN, processingTimeSegmentationN] = scriptStart2('segmentation', false , 1,classifier,true);
% [meanVectorOptDigit, stdVectorOptDigit, processingTimeOptDigit] = scriptStart2('optdigit', true , 1,classifier,true);