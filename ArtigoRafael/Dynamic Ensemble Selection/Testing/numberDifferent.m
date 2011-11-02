function [ result ] = numberDifferent( ensemble, test, numClassifier )

testPR = dataset(test.data,test.labels);
count = 0;

firstLabel = testPR * ensemble{1} * labeld;

for index = 2 : numClassifier
    
    label = testPR * ensemble{index} * labeld;
    
    if label ~= firstLabel,
        count = count + 1;
    end;
end;

count2 = numClassifier - count;

if count > count2,
    result = count;
else
    result = count2;
end;