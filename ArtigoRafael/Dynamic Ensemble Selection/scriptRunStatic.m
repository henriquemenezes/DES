dstump = stumpc([]);            %decision stumps as weak classifiers
perceptron = perlc([]);         %perceptron as weak classifiers
dtree = treec([],'infcrit',0);      %decision trees classifer
quadratic = qdc([]);            %quadratic discriminant classifier
bayes = naivebc([]);            %naive bayes classifier
parzen = parzenc([]);           %parzen classifier
neural = lmnc([],5);
knearests = knnc([],1);
linearSVM = svc([]);

classifier = quadratic;

% [meanStaticSonar, stdStaticSonar, meanSingleBestSonar, stdSingleBestSonar, meanOracleSonar,stdOracleSonar] = scriptSingleBestStatic('sonar', classifier);
% [meanStaticIonosphere, stdStaticIonosphere, meanSingleBestIonosphere, stdSingleBestIonosphere, meanOracleIonosphere,stdOracleIonosphere] = scriptSingleBestStatic('ionosphere', classifier);
% [meanStaticPima, stdStaticPima, meanSingleBestPima, stdSingleBestPima, meanOraclePima,stdOraclePima] = scriptSingleBestStatic('pima', classifier);
% [meanStaticLiver, stdStaticLiver, meanSingleBestLiver, stdSingleBestLiver, meanOracleLiver,stdOracleLiver] = scriptSingleBestStatic('liver', classifier);
% [meanStaticBanana, stdStaticBanana, meanSingleBestBanana, stdSingleBestBanana, meanOracleBanana,stdOracleBanana] = scriptSingleBestStatic('banana', classifier);
% [meanStaticLithuanian, stdStaticLithuanian, meanSingleBestLithuanian, stdSingleBestLithuanian, meanOracleLithuanian,stdOracleLithuanian] = scriptSingleBestStatic('lithuanian', classifier);
% [meanStaticBlood, stdStaticBlood, meanSingleBestBlood, stdSingleBestBlood, meanOracleBlood,stdOracleBlood] = scriptSingleBestStatic('blood', classifier);
% [meanStaticBreast, stdStaticBreast, meanSingleBestBreast, stdSingleBestBreast, meanOracleBreast,stdOracleBreast] = scriptSingleBestStatic('breast', classifier);
% [meanStaticVehicle, stdStaticVehicle, meanSingleBestVehicle, stdSingleBestVehicle, meanOracleVehicle,stdOracleVehicle] = scriptSingleBestStatic('vehicle', classifier);
[meanStaticSegmentation, stdStaticSegmentation, meanSingleBestSegmentation, stdSingleBestSegmentation, meanOracleSegmentation,stdOracleSegmentation] = scriptSingleBestStatic('segmentation', classifier);
[meanStaticOptDigit, stdStaticOptDigit, meanSingleBestOptDigit, stdSingleBestOptDigit, meanOracleOptDigit,stdOracleOptDigit] = scriptSingleBestStatic('optdigit', classifier);
