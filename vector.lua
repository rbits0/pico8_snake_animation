-- vector.lua


function get_magnitude_and_direction(start_p, end_p)
    local length = end_p[1] - start_p[1]
    local height = end_p[2] - start_p[2]

    local magnitude = sqrt(length^2 + height^2)
    local direction = atan2(length, height)
    
    return magnitude, direction
end


function get_end_point_from_vector(start_p, magnitude, direction)
    local length = magnitude * cos(direction)
    local height = magnitude * sin(direction)
    
    return { start_p[1] + length, start_p[2] + height }
end