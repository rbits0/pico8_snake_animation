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


function scale_points_distance(start_p, end_p, size)
    local magnitude, direction = get_magnitude_and_direction(
        start_p,
        end_p
    )
    
    magnitude = size
    local end_p = get_end_point_from_vector(
        start_p,
        magnitude,
        direction
    )
    
    return end_p
end


-- get points rotated around center_p 90 degrees and -90 degrees
function get_rotated_points(center_p, edge_p, size)
    if size != nil then
        edge_p = scale_points_distance(center_p, edge_p, size)
    end

    local width = edge_p[1] - center_p[1]
    local height = edge_p[2] - center_p[2]

    local left_x = center_p[1] + height    
    local left_y = center_p[2] - width
    local right_x = center_p[1] - height
    local right_y = center_p[2] + width
    
    return {left_x, left_y}, {right_x, right_y}
end