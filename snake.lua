-- snake.lua

Snake = {
    new = function(head_x, head_y, length, gap_size) 
        -- generate points

        local head = {head_x, head_y}
        points = {head}

        for i=2, length do
            local new_point = {
                points[i - 1][1] - gap_size,
                points[i-1][2],
            }
            add(points, new_point)
        end

        local obj = {
            points = points,
            gap_size = gap_size,
        }
        
        setmetatable(obj, { __index = function(table, key)
            return Snake[key]
        end })
        
        return obj
    end,
    

    constrain = function(self)
        local prev = nil
        printh("A")
        
        for curr in all(self.points) do
            if prev != nil then
                local magnitude, direction = get_magnitude_and_direction(
                    prev,
                    curr
                )
                
                magnitude = self.gap_size
                printh(curr[1].." "..curr[2])
                local end_p = get_end_point_from_vector(
                    prev,
                    magnitude,
                    direction
                )
                curr[1] = end_p[1]
                curr[2] = end_p[2]
                printh(curr[1].." "..curr[2])
            end

            prev = curr
        end
    end,
    

    draw = function(self)
        local prev = self.points[1]
        for i=2, #self.points do
            local curr = self.points[i]
            line(prev[1], prev[2], curr[1], curr[2], 7)
            prev = curr
        end
        
        -- for point in all(self.points) do
        --     pset(point[1], point[2], 8)
        -- end
    end
}