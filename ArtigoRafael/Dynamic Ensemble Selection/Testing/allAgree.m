function [ result ] = allAgree( ensemble, test, numClassifier )

testPR = dataset(test.data, test.labels);
result = true;

firstLabel = testPR * ensemble{1} * labeld;

for index = 2 : numClassifier
    
    label = testPR * ensemble{index} * labeld;
    
    if label ~= firstLabel,
        result = false;
        break;
    end;
end;