function [points, ranges, wall_index] = findAllRange(pos, n_beams, walls)
    angles = 0:2*pi/n_beams:2*pi-2*pi/n_beams;
    [beam_x,beam_y] = pol2cart(angles,1);
    dir = [beam_x;beam_y];
    points = zeros(2,length(dir));
    ranges = zeros(n_beams, 1); wall_index = zeros(n_beams, 1);
    for i = 1:length(dir)
        [ranges(i), wall_index(i)] = findRange(walls, dir(1:2,i), pos);
        points(:,i) = pos + ranges(i)*dir(:,i);
    end
end