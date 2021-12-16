function target_cord(agent, speed, target_x, target_y) 

ang = atan2(target_y - agent.y, target_x - agent.x);

move_vector(ang - agent.ang - pi / 2, speed);

end