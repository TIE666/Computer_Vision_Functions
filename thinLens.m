function [output] = thinLens(f,z)
    % Using thin lens equation,
    % given focal length f, image plane / object depth z,
    % return the object / image plane depth z'.
    output = 1 / (1/f - 1/z);
    fprintf("z' = %f\n", output);
end

