function plot_beams(pts, pos, figure_nr, k)
    figure(figure_nr)
    plot(pos(1), pos(2), 'ok', 'MarkerSize', 10)
    title(string(k))
    axis([-7 7 -7 7])
    axis equal
    for i=1:length(pts)
        if pts == Inf
            DISP("Inf point");
            continue
        end
        vec = (pts(:,i)-pos)/norm((pts(:,i)-pos));
        hold on
        if i == 1
            plot([pos(1)+vec(1)*0.7,pts(1,i)], [pos(2)+vec(2)*0.7,pts(2,i)], '-b', 'LineWidth', 2)
            plot(pts(1,i), pts(2,i), 'rx', 'MarkerSize', 10)
        elseif ~mod(i-1,length(pts)/4)
            plot([pos(1)+vec(1)*0.7,pts(1,i)], [pos(2)+vec(2)*0.7,pts(2,i)], '-r', 'LineWidth', 2)
            plot(pts(1,i), pts(2,i), 'rx', 'MarkerSize', 10)
        else
            plot([pos(1)+vec(1)*0.7,pts(1,i)], [pos(2)+vec(2)*0.7,pts(2,i)], '--b', 'LineWidth', 0.2)
            plot(pts(1,i), pts(2,i), 'rx', 'MarkerSize', 10)
        end
        hold off
    end
end