function [v_ref, x, w] = collision_avoidance_function(x, w, wp, hgt, A_d, n_beams, Walls, k)
    [points, ranges, ~] = findAllRange(x(1:2,k),n_beams,Walls);
    beams = [points-x(1:2,k);ranges'];
    v_ref(:,k) = sat(wp(:,w)-x(1:2,k),0.5);
    v_ref(:,k) = collision_avoidance(beams, x(:,k), 0.5, 1.5, v_ref(:,k), 2);
    x(3:4,k+1) = x(3:4,k) + 0.1*(v_ref(:,k)-x(3:4,k));
    x(1:2,k+1) = A_d(1:2,:)*x(:,k);
    if norm(x(1:2,k)-wp(:,w)) < 0.5
        w = w+1;
        if w == length(wp)+1
            w = -1;
            return
        end
        plot(wp(1,w),wp(2,w), 'r*')
    end
    if ~mod(k,10)
        Tx = makehgtform('translate',[x(1,k+1)-x(1,1) x(2,k+1)-x(2,1) 0]);
        set(hgt,'Matrix',Tx);
        drawnow;
        pause(0.02)
    end
end