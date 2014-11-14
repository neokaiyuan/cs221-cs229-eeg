dog = 'Dog_5';
[feature_matrix, num_interictal, num_preictal] = Get_DWT_Features(dog);
feature_matrix = permute(feature_matrix,[1 3 2]);
feature_matrix = reshape(feature_matrix,[size(feature_matrix,1) size(feature_matrix,2)*size(feature_matrix,3)]);
[coeff,score,latent] = pca(feature_matrix);
num_not_halved = 0;
cutoff = 3;
% for i = 1:size(latent,1)-1
%     if latent(i)/latent(i+1) < 2
%         num_not_halved = num_not_halved + 1;
%     else
%         num_not_halved = 0;
%     end
%     
%     if latent(i) / sum(latent) < 0.05 && num_not_halved > 1
%         cutoff = i+1;
%         break
%     end
% end

new_features = zeros(size(feature_matrix,1),cutoff);
for i = 1:size(feature_matrix,1)
    for j = 1:cutoff
        new_features(i,j) = dot(coeff(j,:),feature_matrix(i,:));
    end
end

new_features_train = [new_features(151:450,:)' new_features(461:480,:)']';
labels_train = [-ones(1,300) ones(1,20)]';
new_features_cross_val = [new_features(1:150,:)' new_features(451:460,:)']';
labels_cross_val = [-ones(1,150) ones(1,10)]';

% labels = [-ones(1,num_interictal) ones(1,num_preictal)]';
model = fitcsvm(new_features_train,labels_train,'KernelFunction','polynomial',...
                                    'BoxConstraint',Inf,'ClassNames',[-1,1]);

label = predict(model,new_features_cross_val);
num_correct = 0;
for i = 1:size(label,1)
    if label(i) == labels_cross_val(i)
        num_correct = num_correct+1;
    end
end

display(['Accuracy on training data = ' num2str(100*num_correct/size(label,1))])
sum(label)
% model = train(labels, new_features);



        