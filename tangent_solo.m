function [tangent_cord] = tangent_solo (obstacle, radius, target, position)

        tangent_cord = [0, 0];

        A = target(2) - position(2);
        B = (target(1) - position(1)) * -1;
        C = (target(2) - position(2)) * -position(1) + (target(1) - position(1)) * position(2);

        d = (A * obstacle(1) + B * obstacle(2) + C) / sqrt(A^2 + B^2);

        if abs(d) < radius

        ang1 = atan2(target(1) - position(1), target(2) - position(2));
        vec1 = [radius * cos(ang1), radius * sin(ang1)];
        tangent_cord = target + vec1;
        disp('(solo) obstacle avoidance'); 

        else
            disp('(solo) no obstacle'); 
        end
end