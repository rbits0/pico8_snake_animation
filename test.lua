-- test.lua


function run_tests()
    test_ensure_min_angle_1()
    
    printh("Tests ran successfully")
end


function test_ensure_min_angle_1()
    local center = {100, 100}
    local point1 = {102, 98} -- 45 degrees (0.125 normalised)
    local point2 = {102, 99} -- 26.6 degrees (0.0738 normalised)
    -- 0.0512 difference
    
    local magnitude1, angle1 = get_magnitude_and_direction(center, point1)
    local magnitude2, angle2 = get_magnitude_and_direction(center, point2)
    assert(angle1 == 0.125)
    assert(roughly_equal(angle2, 0.0738, 0.001))
    
    -- ensure 27 degrees min
    local new_point2 = ensure_min_angle(center, point1, point2, 0.075)
    local new_magnitude2, new_angle2 = get_magnitude_and_direction(center, new_point2)
    assert(roughly_equal(
        subtract_angle(angle1, new_angle2),
        0.075,
        0.001
    ))
end



function roughly_equal(num1, num2, margin)
    return abs(num1 - num2) < margin
end