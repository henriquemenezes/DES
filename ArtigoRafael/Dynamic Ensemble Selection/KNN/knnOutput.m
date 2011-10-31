function [ distances,idx ] = knnOutput( outputTraining, outputTest )

[row, column] = size(outputTraining);
distances = [];
for i = 1 : row
    
    distance = sum( abs( outputTraining(i,:) - outputTest(1,:) ) );
    distances = [distances distance];
    
end;

[distances, idx] = sort(distances,'ascend');