function [output] = gaussianmask(xmap, ymap,sigma)
    % Return a gaussian mask with given x / y coordinate maps and sigma.
    G = zeros(size(xmap));
    for i = 1:size(G,1)
       for j = 1:size(G,2)
           x = xmap(i,j);
           y = ymap(i,j);
           G(i,j) = 1/(2*pi*sigma^2) * exp(-(x^2+y^2)/(2*sigma^2));
       end
    end
    output = G;
end

