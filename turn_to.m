function [turn_speed] = turn_to (agent, k, target)
% agent is "RP.Blue(control_ID)"  k is 10  (default)

    
    vec_ang = [cos(agent.ang), sin(agent.ang)];
    vec_target = [target(1) - agent.x, target(2) - agent.y];

    ang = atan2(psev_dot(vec_ang, vec_target), dot(vec_ang, vec_target));

%     if abs(ang) < pi / 15    %fix for bad camera data
%         turn_speed = 0;
%     else
        turn_speed = ang * k;
%     end
        
end