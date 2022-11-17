function h = plot_wall(wall, figure_nr)
    figure(figure_nr)
    hold on
    wall_parallel_vec = [0,1;-1,0]*wall(1:2)';
    wall_pt1 = -wall(1:2)'*wall(3)+wall(4)*wall_parallel_vec;
    wall_pt2 = -wall(1:2)'*wall(3)+wall(5)*wall_parallel_vec;
    wall_pts = [wall_pt1,wall_pt2];
    h = plot(wall_pts(1,:), wall_pts(2,:), '-k', 'LineWidth', 2);
    hold off
end