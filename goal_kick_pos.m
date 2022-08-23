function [targ] = goal_kick_pos (goalkeeper_pos, position, goal)
global goal_weight
delta_to_kick = 150;

if norm(goal - position) > 1750
    targ = goal;
    disp('too far');
else
    vec_to_goalk = goalkeeper_pos - position;
    vec_to_goal = goal - position;

    proect_goalk = vec_to_goalk(2) * (vec_to_goal(1) / vec_to_goalk(1)) + position(2);    %projection of the enemy goalk to the goal line

    if abs(proect_goalk) > goal_weight
        targ = goal;
        disp('no goalk');
    elseif proect_goalk > 0
        targ = goal - [0, goal_weight - delta_to_kick];
        disp('moving up');
    else
        targ = goal + [0, goal_weight - delta_to_kick];
        disp('moving down')
    end
    
end