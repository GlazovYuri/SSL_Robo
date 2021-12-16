function [tangent_cord] = tangent_solo (obstacle, radius, target, position)

        tangent_cord = [0, 0];

        A = target(2) - position(2);
        B = (target(1) - position(1)) * -1;
        C = (target(2) - position(2)) * -position(1) + (target(1) - position(1)) * position(2);

        d = (A * obstacle(1) + B * obstacle(2) + C) / sqrt(A^2 + B^2);

        if abs(d) < radius

            l = sqrt(radius^2 - d^2);

            way_x = target(1) - position(1);
            way_y = target(2) - position(2);

            vec1 = [-d * sin(atan2(way_y, way_x)), d * cos(atan2(way_y, way_x))];
            vec2 = [-l * sin(atan2(way_y, way_x) - pi / 2), l * cos(atan2(way_y, way_x) - pi / 2)];
            vec3 = [-l * sin(atan2(way_y, way_x) + pi / 2), l * cos(atan2(way_y, way_x) + pi / 2)];

            tangent1 = obstacle + vec1 + vec2;
            tangent2 = obstacle + vec1 + vec3;


            if target(1) > position(1)
                right = target(1);
                left = position(1);
            else
                right = position(1);
                left = target(1);
            end

%             disp('point');
%             disp([left, right]);

            if tangent1(1) < right && tangent1(1) > left && tangent2(1) < right && tangent2(1) > left

                if d > 0
                    ang1 =   atan2(position(2) - obstacle(2), position(1) - obstacle(1))  - asin(radius / sqrt((position(1) - obstacle(1))^2 + (position(2) - obstacle(2))^2));
                    disp('(solo) left way');
                    disp(ang1 * 180 / pi);
                else
                    ang1 =  -atan2(position(2) - obstacle(2), position(1) - obstacle(1))  - asin(radius / sqrt((position(1) - obstacle(1))^2 + (position(2) - obstacle(2))^2));
                    disp('(solo) right way');
                    disp(ang1 * 180 / pi);
                end
                vec4 = [radius * cos(ang1), radius * sin(ang1)];
                tangent_cord = obstacle + vec4;
%                 disp('start');
%                 disp(obstacle);
%                 disp(ang1 * 180 / pi);
%                 disp('vec4');
%                 disp(vec4);
%                 disp('start');
%                 disp(tangent_cord);
            else
                  disp('(solo) obstacle don"t interfere');
            end
        else
            disp('(solo) no obstacle'); 
        end
end