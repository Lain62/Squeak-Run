class Player
    attr_gtk
    attr_sprite
    attr_accessor :dx, :dy, :status, :respawn_point, :safe_status, :cheese_status, :win_status
    def initialize(x, y)
        self.args = $args
        @x = x
        @y = y
        @dx = 0
        @dy = 0
        @jump_count = 2
        @gravity_power = 1
        @gravity_max = -14
        @jump_power = 10
        @jump_timer = 0
        @jump_timer_max = 10
        @speed = 4
        @status = :unspawned
        @safe_status = :unsafe
        @respawn_point = 0
        @w = 64
        @h = 64
        @path = "sprites/circle/blue.png"
        @cheese_status = :ungrabbed
        @win_status = :default
    end

    def hazard_collision
        inside_hazard = state.game.entity_group.hazards.any? do |object|
            Geometry.intersect_rect?(self, object)
        end

        if inside_hazard
            @status = :death
        end
    end

    def safe_zone_collision
        inside_safe = state.game.entity_group.safe_zone.any? do |object|
            Geometry.intersect_rect?(self, object)
        end

        if inside_safe
            @safe_status = :safe
        else
            @safe_status = :unsafe
        end
    end

    def collision
        player_x = {
            x: @x + @dx,
            y: @y,
            w: @w,
            h: @h
        }

        player_y = {
            x: @x,
            y: @y + @dy,
            w: @w,
            h: @h
        }
        collided_x = state.game.entity_group.collisions.any? do |object|
            Geometry.intersect_rect?(player_x, object)
        end

        collided_y = state.game.entity_group.collisions.any? do |object|
            Geometry.intersect_rect?(player_y, object)
        end

        if collided_x == true
            @dx = 0
        
        end

        if collided_y == true
            @dy = 0
            @jump_count = 2
        end
    end

    def jump
        if input_jump_tap && @jump_count > 0
            @jump_timer = @jump_timer_max
            @jump_count -= 1
        end

        if @jump_timer > 0
            @dy = @jump_power
            @jump_timer -= 1
        end
    end

    def gravity
        if @dy > @gravity_max
            @dy -= @gravity_power
        end
    end

    def input_jump_tap
        return true if inputs.keyboard.key_down.space || inputs.keyboard.key_down.z || inputs.keyboard.key_down.j
        return false
    end

    def input_left_right
        @dx = inputs.left_right * @speed
    end

    def move
        gravity
        input_left_right
        jump
        safe_zone_collision
        collision
        @x += @dx
        @y += @dy
    end

    def update
        move
    end
end