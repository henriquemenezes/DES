%peforms the adaptive knearest neighbor algorithm from the paper "Improving nearest neighbor rule with a simple adaptive
%distance measure" Jigang Wang *, Predrag Neskovic, Leon N. Cooper
%adaptiveWeights were pre computed to improve performance
function [nearests,distances,idx] = aknn(data, query, range, k, adaptiveWeights)

%euclidean distance
[row col] = size(data);
distance = zeros(1,row);
nearests = zeros(k,col);

for trainingPattern = 1 : row

    %distance(1,trainingPattern) = ( sum( ((data(trainingPattern,:) - query)).^2 ) ) / adaptiveWeights(1,trainingPattern);
    distance(1,trainingPattern) = ( sum( ((data(trainingPattern,:) - query)./range).^2 ) ) / adaptiveWeights(1,trainingPattern);
    
end;

[distances idx] = sort(distance);

for i = 1 : k
    
    nearests(i,:) = data( idx(1,i), : );
    
end;

