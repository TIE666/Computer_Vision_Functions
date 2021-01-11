function [output] = myrgb2gray(Ir,Ig,Ib,rw,gw,bw)
    % Convert rgb to gray by weighting.
    output = (Ir * rw + Ig * gw + Ib * bw) / (rw+gw+bw);
end

