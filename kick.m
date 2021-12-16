function [power] = kick (agent, goal)

global field_length
dist = field_length;  %half of field

dist0 = norm(goal - agent.z);

if dist0 < dist
    power = 1; %1
else
    power = 0;
end

end