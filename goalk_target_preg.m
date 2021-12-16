function speed_xy = goalk_target_preg(agent, k, target)

ang = atan2(target(2) - agent.y, target(1) - agent.x);

err = sqrt((target(2) - agent.y) ^ 2 + (target(1) - agent.x) ^ 2);

speed = err * k;

if speed > 85
    speed = 85;
end

speed_xy = [sin(ang - agent.ang + pi / 2) * speed, cos(ang - agent.ang + pi / 2) * speed];

end