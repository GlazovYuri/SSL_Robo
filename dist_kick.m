function [power] = kick (agent, ball)    %kick if ball near the robot (fix for autokick)

dist0 = norm(ball.z - agent.z);

if dist0 < 80
    power = 1; %1
else
    power = 0;
end

end