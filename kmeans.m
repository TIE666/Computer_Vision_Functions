function [output] = kmeans(I)
    % kmeans clustering using SAD
    
    I = im2double(I);
    
    % custom centroid start
    c1 = reshape([5 10 15],1,1,3); 
    c2 = reshape([10 10 25],1,1,3);
    
    labels = zeros(size(I,1),size(I,2));
    
    tmpL = zeros(size(labels));
    first = 1;
    while first || sum(labels-tmpL,'all') > 0
        first = 0;
        tmpL = labels;
        for i = 1:size(I,1)
            for j = 1:size(I,2)
                if SAD(c1,I(i,j,:)) < SAD(c2,I(i,j,:))
                    labels(i,j) = 1;
                else
                    labels(i,j) = 2;
                end
            end
        end
        c1 = sum((labels == 1) .* I, [1 2]) ./ sum((labels == 1),'all');
        c2 = sum((labels == 2) .* I, [1 2]) ./ sum((labels == 2),'all');
    end
    
    output = labels;
end

function [output] = SAD(p1,p2)
    output = sum(abs(p1 - p2),'all');
end