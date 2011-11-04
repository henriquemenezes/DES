% Executa o k-NN (c/ Distância Euclidiana)
%
% Entradas:
% - data: conjunto de dados (sem a classe)
% - query: padrão de consulta
% - k: total de vizinhos
%
% Saídas:
% - nearests: os k vizinhos mais próximos
% - distances: as distâncias ordenadas da menor para maior
% - idx: os indices dos k vizinhos com relação a data

function [nearests, distances, idx] = knn(data, query, range, k)

[row col] = size(data);
distance = zeros(1,row);
nearests = zeros(k,col);

for i = 1 : row
    distance(1,i) = sqrt(sum(((data(i,:) - query)./range).^2));    
end;

[distances idx] = sort(distance);

for i = 1 : k    
    nearests(i,:) = data( idx(1,i), : );    
end;