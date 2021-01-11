function [output] = hierarchicalcluster(I)
    % HIERARCHICALCLUSTER Summary of this function goes here
    % input I as a 2D image.
    % rows for individual observation.
    
    obs = zeros(size(I,1)*size(I,2),3);
    count = 1;
    for i = 1:size(I,1)
        for j = 1:size(I,2)
            obs(count,:) = I(i,j,:);
            count = count + 1;
        end
    end
    
    Y = pdist(obs,'cityblock');
    squareform(Y);
    Z = linkage(Y,'average');
    dendrogram(Z);
    % cut the dendrogram horizontally to find cluster at same level.
    % eg: when 3 cluster, you got 3 vertical lines on your cut way.
end

