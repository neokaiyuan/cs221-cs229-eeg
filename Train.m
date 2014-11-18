function [ mdl ] = Train( subj_name, weight )
if exist(['feature_matrix_' subj_name '_train.mat'],'file') == 2
    data = load(['feature_matrix_' subj_name '_train']);
    feature_matrix_train = data.feature_data{1};
    num_interictal = data.feature_data{2};
else
    path = pwd;
    cd('/Volumes/My Passport/EEG_Project')
    addpath(path);
    [feature_matrix_train, num_interictal] = Get_DWT_Features(subj_name, true);
    cd(path);
end

num_preictal = size(feature_matrix_train,1)-num_interictal;
labels = [zeros(1,num_interictal) ones(1,num_preictal)]';
W = [ones(1,num_interictal) ones(1,num_preictal)*weight*num_interictal/num_preictal]';
mdl = fitcknn(feature_matrix_train,labels,'NumNeighbors',20,'W',W);
% theta = glmfit(feature_matrix_train(:,1:end-1),labels,'binomial');

end



        