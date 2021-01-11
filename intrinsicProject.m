function [output] = intrinsicProject(camera_coordinate,alpha,beta,principal)
    % Project camera view coordinate to pixel coordinate,
    % given object camera view coordinate (x,y,z),
    % intrinstic camera parameters --
    %   magnification factors α, β in x, y direction,
    %   image principal point (origin) (ox,oy)
    % return pixel coordinate (x',y',z').
    x = camera_coordinate(1);
    y = camera_coordinate(2);
    z = camera_coordinate(3);
    ox = principal(1);
    oy = principal(2);
    projection_operator = [1 0 0 0; 0 1 0 0; 0 0 1 0];
    parameterM = [alpha 0 ox; 0 beta oy; 0 0 1];
    output = 1/z * parameterM * projection_operator * [x;y;z;1];
    fprintf("pixel coordinates: (u,v,1) = (%f,%f,%f)\n", output(1),output(2),output(3));
end

