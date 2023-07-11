function [avg_accuracy,std_accuracy] = classifier_ECOC_SVM(reduct,class)
%%%%%%%%%Train an ECOC multiclass model using SVM binary learners%%%%%%%%% 

data = reduct;          % reduced data
% data = mapminmax(data);	% data normalization
% data = full(data);    % if data matrix is sparse,then uses full function
target = class;         % label: column vector

%% Divide training-test data for K-fold cross-validation
K = 10; 
rng(10); % For reproducibility
indices = crossvalind('Kfold',target,K);% Generate cross-validation indices
% indices = crossvalind('Kfold',size(data,1),K);
accuracy = zeros(1,K);
for i = 1:K
    test = (indices == i);
    train = ~test;
    test_data = data(test,:);
    test_target = target(test,:);
    train_data = data(train,:);
    train_target = target(train,:);
    
%     Mdl = fitcecoc(train_data,train_target);	% SVM model(OVR)
    Mdl = fitcecoc(train_data,train_target,'Coding','onevsone');% SVM model(OVO)
    test_predict_target = predict(Mdl,test_data);
    sumEQ = 0;
    for j = 1:size(test_predict_target,1)
        if test_predict_target(j,1) == test_target(j,1)
            sumEQ = sumEQ + 1;
        end
    end
    accuracy(i) = sumEQ / size(test_target,1);
end

avg_accuracy = mean(accuracy);	% Average or mean value of array
std_accuracy = std(accuracy);	% Standard deviation
% accuracy
% avg_accuracy
% std_accuracy

end