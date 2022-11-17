% l = 0:2*pi/n_beams:2*pi;
% l = l(1:end-1);
% beams = [cos(l)', sin(l)', ranges];
% figure(3)
% plot(beams(:,1).*beams(:,3),beams(:,2).*beams(:,3), 'x')
% axis equal
% beams(:,beams(3,:)<1);
% 
% collision_avoidance(beams, 1, 2);

function f = collision_avoidance(beams, d1, f_ref)
    d1_beams = beams(beams(:,3)<d1, :);
    for i = 1:length(d1_beams)
        beam = d1_beams(1:2,i);
        if f_ref'*beam>0
            c_vec = projected_v(f_ref,beam);
            f = f_ref - c_vec;
        end
    end
end

function v_proj = projected_v(v,dir)
    dir = dir/norm(dir);
    v_proj = (v'*dir)*dir;
end