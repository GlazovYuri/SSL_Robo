%% MAIN START HEADER

global max_speed Blues Yellows Balls Rules FieldInfo RefState RefCommandForTeam RefPartOfFieldLeft RP PAR Modul activeAlgorithm obstacles gameStatus 

if isempty(RP)
    addpath tools RPtools MODUL
end
%
mainHeader();
%MAP();

if (RP.Pause) 
    return;
end

zMain_End=RP.zMain_End;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% CONTROL BLOCK
% if RP.Blue(control_ID).rul.EnableSpinner == false;
%     RP.Blue(control_ID).rul.EnableSpinner = true;
% end

disp('ITERATION');

max_speed = 55;


global field_length field_width
field_length = 4500; %max cord (/2)
field_width = 2500;

goal = [-field_length, 0];
goalk_goal = [-field_length, 0];
goal_weight = 750; %change to width

preg_k =0.3;
goalk_preg_k =0.3;


if (RP.Ball.I > 0)
    ball_backup = RP.Ball;
    if abs(RP.Ball.x) > field_length - 125
        ball_backup.z(1) = (field_length - 125) * RP.Ball.x / abs(RP.Ball.x);
        ball_backup.x = (field_width - 125) * RP.Ball.x / abs(RP.Ball.x);
    end
    if abs(RP.Ball.y) > field_width - 125
        ball_backup.z(2) = (field_width - 125) * RP.Ball.y / abs(RP.Ball.y);
        ball_backup.y = (field_width - 125) * RP.Ball.y / abs(RP.Ball.y);
    end
end

enemy_ID = 4;
control_ID = 4;
goalkeeper_ID = 2;
enemy_goalkeeper_ID = 0;

if control_ID ~=0
    
    obstacles_ID = [];
    for i = 1:8
        if RP.Blue(i).I == 1
            obstacles_ID = [obstacles_ID, i];
        end
    end
    
    obst = tangent(obstacles_ID, RP.Blue, 300, ball_backup.z, RP.Blue(control_ID).z, goal);

    tang = [0, 0];
    
    for i = 1:numel(obst)/2
        if norm(tang) > norm([obst(i),obst(i + 1)]) || tang(1) == 0
            tang = [obst(i*2 - 1),obst(i*2)];
        end
    end

    if tang(1) ~= 0
        speed_xy = target_preg(RP.Blue(control_ID), preg_k, tang);
    else
        disp('point0');
        speed_xy = target_preg(RP.Blue(control_ID), preg_k, ball_kick(ball_backup, RP.Blue(control_ID).z, goal));
        disp('point');
    end
%     if enemy_goalkeeper_ID ~= 0
%         turn_speed = turn_to(RP.Blue(control_ID), 10 , goal_kick_pos(RP.Blue(enemy_goalkeeper_ID).z, RP.Blue(control_ID).z, goal));
%     else
        turn_speed = turn_to(RP.Blue(control_ID), 10 , goal);
%     end
    
    % disp(speed_xy);
    kickd = dist_kick(RP.Blue(control_ID), ball_backup);
    RP.Blue(control_ID).rul = Crul(speed_xy(1), speed_xy(2), kickd, turn_speed, 0);

    %pow_kick = kick(RP.Blue(control_ID), goal);
    %RP.Blue(control_ID).rul.AutoKick = 1;
    %disp(RP.Blue(control_ID).isBallInside);
    
end

if goalkeeper_ID ~= 0
    goalk_targ = goalk_target(ball_backup, goalk_goal, RP.Blue(6));
    goalk_speed_xy = goalk_target_preg(RP.Blue(goalkeeper_ID), goalk_preg_k, goalk_targ);

    psevdo_bot = RP.Blue(goalkeeper_ID);
    psevdo_bot.z = goalk_targ;
    psevdo_bot.x = goalk_targ(1);
    psevdo_bot.y = goalk_targ(2);
    goalk_turn_speed = turn_to(RP.Blue(goalkeeper_ID), 6 , RP.Blue(goalkeeper_ID).z + [0, 100]);

    RP.Blue(goalkeeper_ID).rul = Crul(goalk_speed_xy(1), goalk_speed_xy(2), 0, goalk_turn_speed, 0);
end

%% END CONTRIL BLOCK

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% MAIN END

%Rules

zMain_End = mainEnd();