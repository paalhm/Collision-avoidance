function [range,wall_index] = findRange(wall, beam, pos)
%     figure(2)
%     hold on
%     plot([0,beam(1)],[0,beam(2)], '-r')
%     hold off
%     axis equal
    
    n = length(wall);
    n_wall = wall(:,1:2);
    o_wall = n_wall*[0,1;-1,0]';
    w_range = findWallDistance(wall, pos);
    dir_factor = n_wall*beam;
    ranges = Inf(n,1);
    for i = 1:n
        if (0 < dir_factor(i)) && (w_range(i) > 0)
            extend = (o_wall(i,:)*(pos+beam*(w_range(i)/dir_factor(i))));
            if (wall(i,4) <= extend) && (extend <= wall(i,5))
                ranges(i) = w_range(i)/dir_factor(i);
            end
        end
        if ranges(i) > 30
            ranges(i) = Inf;
        end
    end
    [range,wall_index] = min(ranges);
end