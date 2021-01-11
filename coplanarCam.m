function [output] = coplanarCam(ul,ur,f,B)
    % Given x coordinate on left image ul, 
    % x coordinate on right image ur, focal length f, baseline B
    % return the depth Z of the object point.
    disparity = ul-ur;
    Z = (f*B) ./ disparity;
    fprintf("depth Z: %f, disparity d: %f",Z,disparity);
end

