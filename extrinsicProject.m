function [output] = extrinsicProject(world_coordinate,R,t)
    % Project world coordinate to camera view coordinate,
    % given object world coordinate (X,Y,Z),
    % rotation 3x3 matrix R for camera orientation,
    % transition 3x1 matrix t for camera position,
    % return camera coordinate (x,y,z).
    X = world_coordinate(1);
    Y = world_coordinate(2);
    Z = world_coordinate(3);
    part1 = R.';
    part2 = -R.'*t;
    operator = cat(1,cat(2,part1,part2),[0 0 0 1]);
    output = operator * [X;Y;Z;1];
    fprintf("camera coordinates: (x,y,z) = (%f,%f,%f)\n", output(1),output(2),output(3));
end

