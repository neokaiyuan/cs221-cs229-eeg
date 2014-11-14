function [ feature_matrix, num_interictal, num_preictal ] = Get_DWT_Features( dog_name )
%GET_ Summary of this function goes here
%   Detailed explanation goes here

decomp_level = 5;
features_per_decomp = 4;
num_features = (decomp_level+1)*features_per_decomp-1;
[Lo_D,Hi_D] = wfilters('db2','d');

cd(['../' dog_name]);
cd('preictal');
load([dog_name '_preictal_segment_0001.mat']);
listing = dir;
num_preictal = size(listing,1)-2;
cd('../interictal');
load([dog_name '_interictal_segment_0001.mat']);
listing = dir;
num_interictal = size(listing,1)-2;
num_channels = size(interictal_segment_1.data,1);
feature_matrix = zeros(num_interictal+num_preictal,num_channels,num_features);
clear preictal_segment_1
clear interictal_segment_1

for i = 3:num_interictal+2
    if mod(i,20) == 0
        display([num2str(100*(i-2)/(num_interictal+num_preictal)) '% complete']);
    end
    segment = load(listing(i).name);
    data = segment.(['interictal_segment_' num2str(i-2)]).data;
    features = zeros(num_channels,num_features);
    for ch = 1:num_channels
        [C,L] = wavedec(data(ch,:),decomp_level,Lo_D,Hi_D);
        for d = 1:decomp_level+1
            indeces = sum(L(1:d-1))+1:sum(L(1:d));
            feature_start = (features_per_decomp-1)*(d-1);
            features(ch,feature_start+1) = mean(abs(C(indeces)));
            features(ch,feature_start+2) = mean(C(indeces).^2);
            features(ch,feature_start+3) = std(C(indeces));
        end
        ratio_start = (features_per_decomp-1)*(decomp_level+1);
        for d = 1:decomp_level
            index_1 = (features_per_decomp-1)*(d-1)+1;
            index_2 = (features_per_decomp-1)*d+1;
            features(ch,ratio_start+d) = features(ch,index_1) / features(ch,index_2);
        end
    end
    feature_matrix(i-2,:,:) = features;
end

cd('../preictal');
listing = dir;
for i = 3:num_preictal+2
    if mod(i,20) == 0
        display([num2str(100*(num_interictal+i-2)/(num_interictal+num_preictal)) '% complete']);
    end
    segment = load(listing(i).name);
    data = segment.(['preictal_segment_' num2str(i-2)]).data;
    features = zeros(num_channels,num_features);
    for ch = 1:num_channels
        [C,L] = wavedec(data(ch,:),decomp_level,Lo_D,Hi_D);
        for d = 1:decomp_level+1
            indeces = sum(L(1:d-1))+1:sum(L(1:d));
            feature_start = (features_per_decomp-1)*(d-1);
            features(ch,feature_start+1) = mean(abs(C(indeces)));
            features(ch,feature_start+2) = mean(C(indeces).^2);
            features(ch,feature_start+3) = std(C(indeces));
        end
        ratio_start = (features_per_decomp-1)*(decomp_level+1);
        for d = 1:decomp_level
            index_1 = (features_per_decomp-1)*(d-1)+1;
            index_2 = (features_per_decomp-1)*d+1;
            features(ch,ratio_start+d) = features(ch,index_1) / features(ch,index_2);
        end
    end
    feature_matrix(num_interictal+i-2,:,:) = features;
end

cd('../..');