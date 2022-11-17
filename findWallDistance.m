function wall_dist = findWallDistance(wall, p)
    wall_dist = -(wall(:,1:2)*p + wall(:,3));
end