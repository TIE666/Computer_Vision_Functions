function [output] = videoDepthAlongX(x1,x2,t,f,Vcam)
    % Given the two correspondiing point in image1 and image2,
    % x1, x2, unit pixel,
    % the time between shots t, focal lengh f, camera velocity,
    % return the depth of the identified scene point.
    % This is used for motion along the optical axis.
    xdot = (x2-x1)/t;
    Z = -(f * Vcam) / xdot;
    fprintf("Depth Z: %f\n",Z);
    output = Z;
end

