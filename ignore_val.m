function val = ignore_val(val,thres)
    if abs(val) < thres
        val = 0;
    end
end