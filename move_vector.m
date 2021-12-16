function rul = move_vector (ang, speed)

    rul = Crul(sin(ang) * speed, cos(ang) * speed, 0, 0, 0);

end