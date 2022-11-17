function f = sat(f, val)
    f_sat = val * f/norm(f);
    if norm(f) > val
        f = f_sat;
    end
end