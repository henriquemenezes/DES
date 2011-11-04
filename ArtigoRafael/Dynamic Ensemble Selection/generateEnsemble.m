% Função usada para gerar os ensemble (conjunto de classificadores). O ensemble pode ser gerado
% usando ambos os métodos Adaboost ou Bagging. O vetor é combinado com os valores dos pesos 
% quando o método Adaboost é usado.
%
% Entradas:
% - data: conjunto de dados (sem a classe)*
% - numClassifiers: total de classificadores
% - method: método de geração (Adaboost=1) ou (Bagging=0)
% - weakClassifier: tipo de classificadores
%
% Saídas:
% - ensemble: conjunto de classificadores gerados
% - combined: vetor com os pesos (Adaboost)

function [ensemble, combined] = generateEnsemble( data, numClassifiers, method, weakClassifier )

combined = []; % usado para o Adaboost

if method == 0,
    ensemble = baggingc(data, weakClassifier, numClassifiers,[],[]);
elseif method == 1,
    [combined, ensemble, alf] = adaboostc(data, weakClassifier, numClassifiers);
else
    ensemble = rsscc(data, weakClassifier, 4, numClassifiers);
end;


