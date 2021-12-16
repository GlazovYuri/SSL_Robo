function [targ] = goal_kick_pos (goalkeeper_pos, position, goal)
global goal_width
delta_to_kick = 150;

if norm(goal - position) > 1250
    targ = goal;
    disp('too far');
else
    vec_to_up = (goal + [0, goal_weight]) - position;
    vec_to_down = (goal - [0, goal_weight]) - position;
    vec_to_goalk = goalkeeper_pos - position;
    
    up_ang = sin(vec_to_up) / abs(cos(vec_to_up));
    down_ang = sin(vec_to_down) / abs(cos(vec_to_down));
    goalk_ang = sin(vec_to_goalk) / abs(cos(vec_to_goalk));

    if goalk_ang < down_ang || goalk_ang > up_ang
        targ = goal;
        disp('no goalk');
    elseif up_ang - goalk_ang > goalk_ang - down_ang
        targ = goal - [0, delta_to_kick];
        disp('moving up');
    else
        targ = goal + [0, delta_to_kick];
        disp('moving down')
    end
    
end