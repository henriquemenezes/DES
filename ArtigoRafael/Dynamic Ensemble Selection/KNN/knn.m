%peforms the knearest neighbor algorithm. data is the dataset, query is the
%test instance, range is the normalization vector and k is the number o
%neighbors
function [nearests,distances,idx] = knn(data, query, k)

%euclidean distance
[row col] = size(data);
distance = zeros(1,row);
nearests = zeros(k,col);

for i = 1 : row
     
    distance(1,i) = sum( ((data(i,:) - query)).^2 );
  %  distance(1,i) = sum( ((data(i,:) - query)./range).^2 );
    
end;

[distances idx] = sort(distance);

for i = 1 : k
    
    nearests(i,:) = data( idx(1,i), : );
    
end;



