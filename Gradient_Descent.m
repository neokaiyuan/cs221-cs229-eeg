function [ theta ] = Gradient_Descent( X, Y, alpha, num_iterations )
%GRADIENT_DESCENT Summary of this function goes here
%   Detailed explanation goes here

theta = zeros(size(X,2),1);
old_diff = 0;
for i = 1:num_iterations
    old_theta = theta;
    for j = 1:size(X,1)
        if 1/(1+exp(dot(theta,X(j,:)))) >= 0.5
            h = 1;
        else
            h = 0;
        end
        theta = theta + alpha*(Y(j)-h)*X(j,:)';
    end
    if norm(old_theta-theta) == old_diff
        break
    end
    old_diff = norm(old_theta-theta);
end

end

