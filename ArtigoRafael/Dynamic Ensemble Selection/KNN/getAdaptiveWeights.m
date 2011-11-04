% Distância Adaptativa usada no AkNN (Adaptive kNN)

function [adaptiveWeights] = getAdaptiveWeights(data, labels)

[row col] = size(data);
adaptiveWeights = [];

for i = 1 : row
    adaptiveWeights = [adaptiveWeights 10000];
end;

% Calcula a menor distância entre um padrão de uma classe diferente
for pattern = 1 : row
    for neighbor = 1: row
        if labels(pattern) ~= labels(neighbor),
            %distance = sum( (( data(pattern,:) - data(neighbor,:) )./range).^2 );
            distance = sum( (( data(pattern,:) - data(neighbor,:) )).^2 );
            if distance < adaptiveWeights(1,pattern),
                adaptiveWeights(1,pattern) = distance;
            end;
        end;
    end;
end;


