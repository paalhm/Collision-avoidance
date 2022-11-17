clf;
close all;
clear all;

seed = randi(10000);
rng(seed);

%Switches
S_slip = 0;

%Simple Map
%
% Walls = [ 0, 1,-10, -5,  5;  %Top Wall
%           0,-1,-10, -5,  5;  %Bottom Wall
%           1, 0, -5,  2, 10;
%           1, 0, -5,-10, -2;
%           1, 0, -2, -2,  2;  %Object left wall
%          -1, 0, -5,-10, 10;
%           0,-1,  2, -5, -2;  %Object top wall
%           0, 1,  2,  2,  5]; %Object bottom wall
% 
% wp = [4,4,1, 4, 4;
%       9,3,0,-3,-9];

%Obstacle Course
Walls = [ -1,  0,  7, -3,  4;   %1
           0, -1,  4, -7, -5;   %2
           1,  0, -5, -4, -1;   %3  
           0, -1,  1, -5,  1;   %4
          -1,  0, -1,  1,  4;   %5
           0, -1,  4,  1,  9;   %6
           1,  0,  9, -4, -2;   %7
           0,  1, -2, -9, -7;   %8
           1,  0,  7, -2,  3;   %9
           0, -1, -3,  7, 13;  %10
          -1,  0,-13, -3,  7;  %11
           0,  1, -7,-13, 13;  %12
           0,  1, -5,  1,  3;  %13
           1,  0, -1, -6, -5;  %14
           0, -1,  6, -3, -1;  %15
          -1,  0,  3,  5,  6;  %16
           1,  0,-13, -7,  3;  %17
           0, -1, -3,-13, -7;  %18
           0, -1,  3,-13,-11;  %19
           1,  0,-11, -3, -1;  %20
           0,  1, -1, 11, 13;  %21
           0, -1,  0, -9, -7;  %22
          -1,  0,  9, -2,  0;  %23
           0,  1,  2,  7,  9]; %24
n_walls = size(Walls,1);
           
wp = [-8, -11,  -8, 2, 12, 8, 12;
      -1,   4, 5.5, 3,  5, 2, -2];

max_view = max(max(ceil(sqrt(Walls(:,3).^2+Walls(:,4:5).^2))));

time_step = 0.01;
time = 120;
t = 0:time_step:time;
n = length(t);
     
n_beams = 20;
x = zeros(4,n);
x(1:2,1) = [-8;-1];

pos = x(1:2,1);
v = zeros(2,n);
v_r_prev = [0;0];
v_max = 2;
d1 = 1;
d2 = 2;

w = 1;

m = 2;
A = [0, 0,   1,   0;
     0, 0,   0,   1;
     0, 0,-0.1,   0;
     0, 0,   0,-0.1];
B = [0, 0;
     0, 0;
     1, 0;
     0, 1];
A_d = eye(4) + A*time_step;
B_d = B*time_step;

k_wp = -0.2;
k_n = 1;

fig_nr = 1;
figure(fig_nr);
for i = 1:n_walls
    h_walls(i) = plot_wall(Walls(i,:),1);
end
hold on
plot(0, 0, 'k*')
plot(wp(1,:),wp(2,:), 'b-*')
h_body = plot(x(1,1),x(2,1), '*g', 'MarkerSize', 8);
hgt=hgtransform('parent', gca);
set(h_body, 'parent',hgt);
axis([-max_view max_view -max_view max_view]);

% sim('input_test.slx')

for k = 1:n
    [v_ref, x, w] = collision_avoidance_function(x, w, wp, hgt, A_d, n_beams, Walls, k);
    if ~mod(k,50)
        k;
    end
%     
    [points, ranges, wall_index] = findAllRange(x(1:2,k),n_beams,Walls);
% %         plot_beams(points, pos, 1, k);
% %         plot_pts(points, pos, 2, k);
%     
    beams = [points-x(1:2,k);ranges'];
%     v_ref(:,k) = sat(wp(:,w)-x(1:2,k),0.5);
    v_ref(:,k) = collision_avoidance(beams, x(:,k), d1, d2, v_ref(:,k), v_max);
%     u_v = kd_r*(v_ref(:,k)-v_ref_prev) + k_v*(x(3:4,k)-v_ref(:,k));
%     u_v = sat(u_v,0.3);
    x(3:4,k+1) = x(3:4,k) + 0.25*(v_ref(:,k)-x(3:4,k));
    x(1:2,k+1) = A_d(1:2,:)*x(:,k);
    if norm(x(1:2,k)-wp(:,w)) < 0.3
        w = w+1;
        if w == length(wp)+1
            break
        end
        plot(wp(1,w),wp(2,w), 'r*')
    end
    v_ref_prev = v_ref(:,k);
    if ~mod(k,10)
        Tx = makehgtform('translate',[x(1,k+1)-x(1,1) x(2,k+1)-x(2,1) 0]);
        set(hgt,'Matrix',Tx);
        drawnow;
        pause(0.02)
    end
    if w == -1
        break
    end
end
display("Time elapsed: " + k*time_step);
