function [output] = regionsplitmerge(I,threshold)
    % Region split and merge, using SAD
    % given a rgb image I,
    % theshold for similar if difference is LESS than it.
    I = im2double(I);
    width = size(I,2);
    height = size(I,1);
    
    % pad
    if mod(height,2) > 0
        I(height+1,:,:) = I(height,:,:);
        height = height+1;
    end
    if mod(width,2) > 0
        I(:,width+1,:) = I(:,width,:);
        width = width+1;
    end
    % spliting
    fprintf("spliting...");
    labels = ones(height,width);
    curLabel = 1;
    
    regions = {[1 1; height width]};
    while size(regions,1) > 0
        region = regions{1,:};
        if ~allsimilar(region,I,threshold)
            [regions,labels,curLabel] = split(region,regions,labels,curLabel);
        end
        regions(1,:) = [];
    end
    %%%labels
    
    % merging
    fprintf("merging...\n");
    final = zeros(height,width);
    
    seedrow = 1;
    seedcol = 1;
    while sum(~final, "all") > 0
        curLabel = labels(seedrow,seedcol);
        curProperty = sum((labels == curLabel).* I, [1 2]) ./ sum(labels == curLabel,'all');
        I = (labels ~= curLabel) .* I + (labels == curLabel) .* curProperty;
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

function [output] = allsimilar(region, I, threshold)
    region = I(region(1,1):region(2,1),region(1,2):region(2,2),:);
    region = sum(region,3);
    maxi = max(region,[],'all');
    mini = min(region,[],'all');
    output = (maxi - mini) < threshold;
end

function [output,labels,curLabel] = split(region,regions,labels,curLabel)
    topleft = region(1,:);
    botrigt = region(2,:);
    mid = floor([(botrigt(1)+topleft(1))/2,(botrigt(2)+topleft(2))/2]);
    regions{end+1,:} = [topleft; mid];
    regions{end+1,:} = [topleft(1) mid(2)+1; mid(1) botrigt(2)];
    regions{end+1,:} = [mid(1)+1 topleft(2); botrigt(1) mid(2)];
    regions{end+1,:} = [mid+1; botrigt];
    labels(topleft(1):mid(1),topleft(2):mid(2)) = curLabel;
    curLabel = curLabel + 1;
    labels(topleft(1):mid(1),mid(2)+1:botrigt(2)) = curLabel;
    curLabel = curLabel + 1;
    labels(mid(1)+1:botrigt(1),topleft(2):mid(2)) = curLabel;
    curLabel = curLabel + 1;
    labels(mid(1)+1:botrigt(1),mid(2)+1:botrigt(2)) = curLabel;
    curLabel = curLabel + 1;
    output = regions;
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