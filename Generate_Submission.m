subjects = {'Dog_1', 'Dog_2', 'Dog_3', 'Dog_4', 'Dog_5', 'Patient_1', 'Patient_2'};

weight_scale = 8/3;
labels = {'clip', 'preictal'};
for i = 1:size(subjects,2)
    display(['Training on subject ' subjects{i}]);
    theta = Train(subjects{i}, weight_scale);
    display(['Testing on subject ' subjects{i}]); 
    test_labels = Test(subjects{i}, theta);
    labels = [labels' test_labels']';
    cell2csv(['submission_' num2str(x) '.csv'], labels, ',', '2011', '.');
end
