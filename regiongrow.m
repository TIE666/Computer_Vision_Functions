function [output] = regiongrow(I,threshold)
    % Region growing, using SAD (sum of absolute difference), 
    % given a rgb image I, 
    % theshold for similar if difference is LESS than it.
    I = im2double(I);
    width = size(I,2);
    height = size(I,1);
    
    labels = zeros(height,width);
    
    curLabel = 1;
    seedrow = 1;
    seedcol = 1;
    while sum(~labels, "all") > 0
        labels(seedrow,seedcol) = curLabel;
        openls = labels == curLabel;
        while sum(openls,'all') > 0
            [row,col] = find(openls,1);
            openls(row,col) = 0;
            [labels,openls] = add_valid_neighbors(I,row,col,threshold,curLabel,labels,openls);
        end
        curLabel = curLabel + 1;
        [seedrow,seedcol] = find(~labels,1);
    end
    output = labels;
end

function [labels,openls] = add_valid_neighbors(I,row,col,threshold,curLabel,labels,openls)
    % 8 neighbors
    for i = -1:1
       for j = -1:1 
           try
               if labels(row+i,col+j) == 0 && ...
                       SAD(I(row,col,:),I(row+i,col+j,:)) < threshold
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
