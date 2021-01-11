function [output] = harrisDetect(Ix,Iy,k)
    % Return Harris response given x and y derivatives, and variablee k.
    % derivatives are summed over an equally weighted, 
    % 3 by 3 window around each pixel (same-conv with 3x3 ones).
    Ix2 = Ix.^2;
    Iy2 = Iy.^2;
    IxIy = Ix .* Iy;
    
    sum_Ix2 = conv2(Ix2,ones(3,3),'same');
    sum_Iy2 = conv2(Iy2,ones(3,3),'same');
    sum_IxIy = conv2(IxIy,ones(3,3),'same');
    
    R = (sum_Ix2 .* sum_Iy2 - sum_IxIy.^2) - k.*(sum_Ix2+sum_Iy2).^2;
    output = R;
    fprintf("large positive = corners, large negative = edges, close to zero = flats\n");
end

