function [output] = templateMatching(T,I)
    % Template mathcing using different metrics
    Twidth = size(T,2);
    Theight = size(T,1);
    Iwidth = size(I,2);
    Iheight = size(I,1);
    hNumOfT = Iheight - Theight + 1;
    wNumOfT = Iwidth - Twidth + 1;
    output = zeros(hNumOfT,wNumOfT);
    for i = 1:hNumOfT
        for j = 1:wNumOfT
            window = I(i:i+Theight-1,j:j+Twidth-1);
            % choose method
            output(i,j) = ccoef(window,T);
        end
    end
end

function [ncc] = ncc(window,T)
    % normalized cross correlation / cosin similarity
    ncc = sum(window.*T,'all') ./ (sqrt(sum(T.^2,'all')) *...
        sqrt(sum(window.^2,'all')));
end

function [sad] = sad(window,T)
    % sum of absolute difference
    sad = sum(abs(window - T),'all');
end

function [ccorr] = ccorr(window,T)
    % cross correlation
    ccorr = sum(window .* T,'all');
end

function [ccoef]  =ccoef(window,T)
    % cross coefficient
    windowMean = mean(window,'all');
    TMean = mean(T,'all');
    ccoef = sum((T-TMean).*(window-windowMean),'all') ./ ...
        (sqrt(sum((T-TMean).^2,'all')) .* ...
        sqrt(sum((window-windowMean).^2,'all')));
end
