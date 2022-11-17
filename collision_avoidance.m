function v_ref = collision_avoidance(beams, x, d1, d2, v_ref, v_max)
    v
    D_beams = beams(:, beams(3,:)<d2);
    v = x(3:4);
    for i = 1:size(D_beams,2)
        beam = D_beams(1:2,i);
        r = D_beams(3,i);
        v_beam = projected_v(v_ref,beam);
        if r < d1
            f_t = (v_ref - v_beam);
            v_ref = f_t;
        elseif v'*beam > 0
            brk_scale = (r-d1)/(d2-d1);
            if brk_scale*v_max < norm(v_beam)
                v_ref = brk_scale*v_ref;
            end
        end
    end
end