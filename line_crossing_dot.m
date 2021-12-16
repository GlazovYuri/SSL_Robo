function [x, y] = line_crossing_dot (dot1, vec1, dot2, vec2)
    t = - psev_dot(dot1 - dot2, vec2) / psev_dot(vec1, vec2);

    f = dot1 + vec1 * t;
    
    x=f(1);
    y=f(2);
end