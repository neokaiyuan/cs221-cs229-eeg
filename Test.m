function [ test_labels ] = Test( subj_name, mdl )
%TEST Summary of this function goes here
%   Detailed explanation goes here
if exist(['feature_matrix_' subj_name '_test.mat'],'file') == 2
    data = load(['feature_matrix_' subj_name '_test']);
    feature_matrix = data.feature_data{1};
    num_test = data.feature_data{2};
else
    path = pwd;
    cd('/Volumes/My Passport/EEG_Project');
    addpath('~/Dropbox/EEG_Project/cs221-cs229-eeg');
    [feature_matrix, num_test] = Get_DWT_Features(subj_name, false);
    cd(path)
end

test_labels = cell(num_test,2);
label = predict(mdl,feature_matrix);
for i = 1:num_test
    test_labels{i,1} = [subj_name '_test_segment_' sprintf('%04d',i) '.mat'];
%     if 1/(1+exp(dot(theta,feature_matrix(i,:)))) >= 0.5
%         test_labels{i,2} = 1;
    test_labels{i,2} = label(i);
%     if dot(theta(2:end),feature_matrix(i,1:end-1))+theta(1) > 0
%          test_labels{i,2} = 1;
%     else
%         test_labels{i,2} = 0;
%     end
end

end

