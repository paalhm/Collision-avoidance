function v_proj = projected_v(v,dir)
    dir = dir/norm(dir);
    v_proj = (v'*dir)*dir;
end