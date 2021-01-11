function [output] = videoDepthAlongZ(x1,x2,t,Vcam)
    % Given two correspondiing point in image1 and image2,
    % x1, x2, unit pixel,
    % the time between shots t, camera velocity,
    % return the depth of the identified scene point.
    xdot = (x2-x1)/t;
    Z = (Vcam * x1) / xdot;
    fprintf("Depth Z: %f\n",Z);
    output = Z;
end
