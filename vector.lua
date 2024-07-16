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


-- returns angle1 if plane was rotated so that angle2 was 0 degrees
function subtract_angle(angle1, angle2)
    local difference = angle1 - angle2
    if difference < 0 then
        difference += 1
    end
    
    return difference
end


function add_angle(angle1, angle2)
    local sum = angle1 + angle2
    if sum > 1 then
        sum -= 1
    end
    
    return sum
end


-- ensures that angle between the points is not less than min_angle
-- returns new value for point2 (point1 doesn't move)
function ensure_min_angle(center, point1, point2, min_angle)
    local magnitude1, angle1 = get_magnitude_and_direction(center, point1)
    local magnitude2, angle2 = get_magnitude_and_direction(center, point2)
    
    local angle_between = subtract_angle(angle2, angle1)

    if angle_between < min_angle then
        angle_between = min_angle
    elseif angle_between > 1 - min_angle then
        angle_between = 1 - min_angle
    end
    
    local new_angle = add_angle(angle_between, angle1)
    local new_point = get_end_point_from_vector(center, magnitude2, new_angle)
    return new_point
end