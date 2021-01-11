function [output] = timeToCollision(x1,x2,t)
    % Given the two correspondiing point in image1 and image2,
    % x1, x2, unit pixel,
    % the time between shots t,
    % return the time-to-collision between movng camera and the secene
    % point.
    xdot = (x2-x1) / t;
    ttc = x1/xdot;
    fprintf("time-to-collision: %f\n",ttc);
    output = ttc;
end

