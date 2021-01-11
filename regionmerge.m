function [output] = regionmerge(I,threshold)
    % Region merge, using SAD,
    % given a rgb image I,
    % theshold for similar if difference is LESS than it.
    I = im2double(I);
    width = size(I,2);
    height = size(I,1);
    
    labels = zeros(height,width);
    curLabel = 1;
    for i = 1:size(I,1)
       for j = 1:size(I,2)
           labels(i,j) = curLabel;
           curLabel = curLabel + 1;
       end
    end
    
    final = zeros(height,width);
    
    seedrow = 1;
    seedcol = 1;
    while sum(~final, "all") > 0
        curLabel = labels(seedrow,seedcol);
        curProperty = I(seedrow,seedcol,:);
        openls = labels == curLabel;
        while sum(openls,'all') > 0
            [row,col] = find(openls,1);
            openls(row,col) = 0;
            [labels,openls] = add_valid_neighbors(I,row,col,threshold,curLabel,curProperty,labels,final,openls);
            curProperty = sum((labels == curLabel).* I, [1 2]) ./ sum(labels == curLabel,'all');
            I = (labels ~= curLabel) .* I + (labels == curLabel) .* curProperty;
        end
        final = final | (labels == curLabel);
        [seedrow,seedcol] = find(~final,1);
    end
    
    output = labels;
end

function [labels,openls] = add_valid_neighbors(I,row,col,threshold,curLabel,curProperty,labels,final,openls)
    % 8 neighbors
    for i = -1:1
       for j = -1:1 
           try
               if labels(row+i,col+j) ~= curLabel && ...
                       ~final(row+i,col+j) &&...
                       SAD(curProperty,I(row+i,col+j,:)) < threshold
                   labels(row+i,col+j) = curLabel;
                   openls(row+i,col+j) = 1;
               end
           catch    
           end
       end
    end
    end

function [output] = SAD(p1,p2)
    output = sum(abs(p1 - p2),'all');
end