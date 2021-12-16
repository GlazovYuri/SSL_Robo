function [targ] = goal_kick_pos (goalkeeper_pos, position, goal)
goal_width = 700;

if norm(goal - position) > 1000
    targ = goal;
    disp('daleko');
else
    
    point1 = tangent_solo(goalkeeper_pos, 150, goal, position);

    if point1(1) == 0
        targ = goal;
        disp('no goalk');
    else
        vec1 = point1 - position;
        vec1 = vec1 / norm(vec1) * (abs(position(1) - goal(1)) / abs(cos(atan2(vec1(2), vec1(1)))));
        
        point_pos = vec1 + position;
        
        if point_pos(2) > 0
            goal_edge = goal + [0, goal_width / 2];
        else
            goal_edge = goal - [0, goal_width / 2];
        end
        
        targ = [(point_pos(1) + goal_edge(1)) / 2, (point_pos(2) + goal_edge(2)) / 2];
        
        disp('moving');
    end
    
end