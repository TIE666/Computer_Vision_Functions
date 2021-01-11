function [output] = epipolarCam(B,theta,al,ar)
    % Prints information given convergence angel theta, baseline B
    % al, ar in degrees.
    disparity = al-ar;
    botAngel = (180-theta)/2;
    angelP = 180 - (botAngel + al) - (botAngel - ar);
    sidePOr = B/sin(deg2rad(angelP)) * sin(deg2rad(botAngel + al));
    sidePOl = B/sin(deg2rad(angelP)) * sin(deg2rad(botAngel - ar));
    area = 0.5 * sidePOr * sidePOl * sin(deg2rad(angelP));
    Z = 2*area/B;
    fprintf("Disparity d: %f, Depth Z: %f\n",disparity,Z);
end

