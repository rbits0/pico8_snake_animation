-- snake.lua

Snake = {
    new = function(head_x, head_y, length, gap_size, min_angle) 
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
            min_angle = min_angle,
        }
        
        setmetatable(obj, { __index = function(table, key)
            return Snake[key]
        end })
        
        return obj
    end,
    

    constrain = function(self)
        local prev = self.points[1]
        
        for i=2, #self.points do
            local curr = self.points[i]
            local next = self.points[i + 1]
            
            -- constrain distance
            constrain_point(curr, prev, self.gap_size)
            
            -- constrain angle
            if next != nil then
                local new_next = ensure_min_angle(curr, prev, next, self.min_angle)
                next[1] = new_next[1]
                next[2] = new_next[2]
            end

            prev = curr
        end
    end,
    

    get_outer_lines = function(self, girth)
        local rotated_points = {}

        local prev = self.points[1]

        -- for all points except head and tail
        for i=2, #self.points - 1 do
            local curr = self.points[i]
            add(rotated_points, pack(get_rotated_points(curr, prev, girth)))
            prev = curr
        end
        
        local outer_lines = {}

        -- go around left edge first
        prev = self.points[1] -- head
        for point in all(rotated_points) do
            local curr = point[1]
            add(outer_lines, {prev, curr})
            prev = curr
        end
        
        -- add tail
        add(outer_lines, {prev, self.points[#self.points]})
        prev = self.points[#self.points]
        
        -- go around right edge in opposite direction
        for i=#rotated_points, 1, -1 do
            local curr = rotated_points[i][2]
            add(outer_lines, {prev, curr})
            prev = curr
        end
        
        -- connect back to head
        add(outer_lines, {prev, self.points[1]})
        
        return outer_lines
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


function constrain_point(point, prev, distance)
    local new_point = scale_points_distance(prev, point, distance)
    point[1] = new_point[1]
    point[2] = new_point[2]
end