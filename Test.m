function [ test_labels ] = Test( subj_name, theta )
%TEST Summary of this function goes here
%   Detailed explanation goes here

[feature_matrix, num_test] = Get_DWT_Features(subj_name, false);

test_labels = cell(num_test,2);
for i = 1:num_test
    test_labels{i,1} = [subj_name '_test_segment_' sprintf('%04d',i) '.mat'];
    if dot(theta(2:end),feature_matrix(i,:))+theta(1) > 0
        test_labels{i,2} = 1;
    else
        test_labels{i,2} = 0;
    end
end

end

