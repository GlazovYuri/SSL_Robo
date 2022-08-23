function speed_xy = target_preg(agent, k, target)

global max_speed field_length field_width

%disp(target);

goal_delta_x = 1100; 
goal_delta_y = 1100; 

if abs(target(1)) > (field_length-goal_delta_x)    %limitation of the robot on the goalkeeper's area
    if abs(target(2)) < goal_delta_y
        if target(1) > 0
            target(1) = field_length-goal_delta_x;
        else
            target(1) = -(field_length-goal_delta_x);
        end
    end
end

%disp(target);

ang = atan2(target(2) - agent.y, target(1) - agent.x);

err = sqrt((target(2) - agent.y) ^ 2 + (target(1) - agent.x) ^ 2);

speed = err * k;    %common p regulator (better update to pi regulator (even better update to pid))

if speed > max_speed
    speed = max_speed;
end

speed_xy = [sin(ang - agent.ang + pi / 2) * speed, cos(ang - agent.ang + pi / 2) * speed];

end