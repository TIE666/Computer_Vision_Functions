function [output] = ppcm(object_coordinate,f)
    % Using prespective pinhole camera model, 
    % given object coordinate (x,y,z) and 
    % focal length (pinhole to image plane length) f,
    % return pixel coordinate (x',y',z')
    x = object_coordinate(1);
    y = object_coordinate(2);
    z = object_coordinate(3);
    projection_operator = [1 0 0 0; 0 1 0 0; 0 0 1 0];
    output = f/z * projection_operator * [x;y;z;1];
    fprintf("pixel coordinates: (x',y',z') = (%f,%f,%f), note: f' = z'\n", output(1),output(2),output(3));
end

