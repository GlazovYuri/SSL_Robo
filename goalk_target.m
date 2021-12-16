function [goalk_pos] = goalk_target (ball, goal, enemy)

    persistent ball_prev_pos ball_pprev_pos mass_x mass_y
    
    max_hist_len = 3;
    
    if isempty(ball_prev_pos)
        ball_prev_pos = [0, 0];
    end
    
    if isempty(ball_pprev_pos)
        ball_pprev_pos = [0, 0];
    end
        
    if goal(1) > 0
        goalk_pos(1) = goal(1) - 300;
        goalk_block = goal(1) - 400;
    else
        goalk_pos(1) = goal(1) + 300;
        goalk_block = goal(1) + 400;
    end

    if norm(ball_prev_pos - goal) > norm(ball.z - goal) + 5
        if numel(mass_x) == 0 || mass_x(numel(mass_x)) ~= ball.x
            mass_x = [mass_x, ball.x];
            mass_y = [mass_y, ball.y];
        end
    else
        mass_x = [];
        mass_y = [];
    end
    
    vec_enemy_ball = enemy.z-ball.z;

    if norm(vec_enemy_ball) < 175 && (vec_enemy_ball(1) * goal(1)) > 0
        goalk_pos(2) = enemy.y + abs(enemy.x - goal(1)) * tan(enemy.ang);
        disp('by enemy"s turning');
    elseif numel(mass_x) >= max_hist_len
        pol = polyfit(mass_x, mass_y, 1);
        goalk_pos(2) = pol(1) * goalk_block + pol(2);
        disp('polyfit');
    else
        goalk_pos(2) = ball.y / 1.7;
        disp('normal_goalk_mode');
    end
    
    
    if goalk_pos(2) > 500
        goalk_pos(2) = 500;
    elseif goalk_pos(2) < -500
        goalk_pos(2) = -500;
    end
    
    
    if(numel(mass_x) > max_hist_len)
      mass_x = mass_x(2:max_hist_len);  
      mass_y = mass_y(2:max_hist_len); 
    end
    
    if ball_pprev_pos ~= ball.z
        ball_prev_pos = ball_pprev_pos;
        ball_pprev_pos = ball.z;
    end
    
end