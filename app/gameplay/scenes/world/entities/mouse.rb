module RatGame
    class Mouse < Sprites
        attr_accessor :spawn_point
        def initialize(x, y, level)
            @level = level
            @x = x
            @y = y
            @w = 16
            @h = 16
            @dx = 0
            @dy = 0
            @xremainder = 0.0
            @yremainder = 0.0
            @dxmovement = 0
            @dymovement = 0
            @gravity = 0
            @gravity_max = 4
            @jump = 0
            @jump_max = 14
            @jump_power = 3
            @jump_count = 0
            @jump_count_max = 2
            @speed = 1.2
            @path = Globals.atlas
            @tile_x = 0
            @tile_y = 0
            @tile_w = 16
            @tile_h = 16
            @flip_horizontally = false
            @spawn_point = 0

            # ANIMATION VARIABLES
            @animation_walk = 0
            @animation_walk_interval = 10
            @animation_walk_frame = 0
            @animation_walk_frame_max = 5

            @animation_jump = 0
            @animation_jump_interval = 10
            @animation_jump_frame = 0
            @animation_jump_frame_max = 4

            @animation_falling = 0
            @animation_falling_interval = 10
            @animation_falling_frame = 0
            @animation_falling_frame_max = 3

            # status
            @cheese_status = :ungrabbed
            @dead_status = false
        end

        ###########
        # ANIMATION
        ###########
        # TODO: REIMPLEMENT THE ANIMATION WALK LOOP AND ANIMATION JUMP WITH YOUR OWN METHOD

        def animation_flip_horizontally
            if @dx > 0
                @flip_horizontally = false
            elsif @dx < 0
                @flip_horizontally = true
            end
        end

        def animation_idle
            if is_idle? && !has_cheese?
                @tile_x = 0
                @tile_y = 0
            elsif is_idle? && has_cheese?
                @tile_x = 0
                @tile_y = 1 * 16
            end
        end

        def animation_walk
            if is_walking? && !has_cheese?
                @animation_walk += 1

                if @animation_walk >= @animation_walk_interval
                    @animation_walk = 0
                    @animation_walk_frame += 1
                end

                if @animation_walk_frame >= @animation_walk_frame_max
                    @animation_walk_frame = 0
                end

                @tile_x = @animation_walk_frame * 16
                @tile_y = 0
            elsif is_walking? && has_cheese?
                @animation_walk += 1

                if @animation_walk >= @animation_walk_interval
                    @animation_walk = 0
                    @animation_walk_frame += 1
                end

                if @animation_walk_frame >= @animation_walk_frame_max
                    @animation_walk_frame = 0
                end

                @tile_x = @animation_walk_frame * 16
                @tile_y = 1 * 16
            else
                @animation_walk = 0
                @animation_walk_frame = 0
            end
        end

        def animation_jump
            if is_jumping? && !has_cheese?
                @animation_jump += 1

                if @animation_jump >= @animation_jump_interval
                    @animation_jump = 0
                    @animation_jump_frame += 1
                end

                if @animation_jump_frame >= @animation_jump_frame_max
                    @animation_jump_frame = @animation_jump_frame_max
                end

                @tile_x = @animation_jump_frame * 16
                @tile_y = 3 * 16
            elsif is_jumping? && has_cheese?
                @animation_jump += 1

                if @animation_jump >= @animation_jump_interval
                    @animation_jump = 0
                    @animation_jump_frame += 1
                end

                if @animation_jump_frame >= @animation_jump_frame_max
                    @animation_jump_frame = @animation_jump_frame_max
                end

                @tile_x = @animation_jump_frame * 16
                @tile_y = 2 * 16
            else
                @animation_jump = 0
                @animation_jump_frame = 0
            end
        end

        def animation_falling
            if is_falling? && !has_cheese?
                @animation_falling += 1

                if @animation_falling >= @animation_falling_interval
                    @animation_falling = 0
                    @animation_falling_frame += 1
                end

                if @animation_falling_frame >= @animation_falling_frame_max
                    @animation_falling_frame = @animation_falling_frame_max
                end

                @tile_x = @animation_falling_frame * 16 + 3 * 16
                @tile_y = 3 * 16
            elsif is_falling? && has_cheese?
                @animation_falling += 1

                if @animation_falling >= @animation_falling_interval
                    @animation_falling = 0
                    @animation_falling_frame += 1
                end

                if @animation_falling_frame >= @animation_falling_frame_max
                    @animation_falling_frame = @animation_falling_frame_max
                end

                @tile_x = @animation_falling_frame * 16 + 3 * 16
                @tile_y = 2 * 16
            else
                @animation_falling = 0
                @animation_falling_frame = 0
            end
        end


        def animation
            animation_flip_horizontally
            animation_idle
            animation_walk
            animation_jump
            animation_falling
        end

        ###########
        # MOVEMENT
        ###########

        def move_jump
            if Globals::Inputs.a_down && @jump_count > 0
                @jump = @jump_max
                @jump_count -= 1
            end

            if @jump > 0
                @jump -= 1
                @dymovement = @jump_power 
                if !Globals::Inputs.a
                    @jump = 0
                end
            end
        end

        def move_gravity
            if !is_grounded? && @jump == 0
                @gravity += 0.25 unless @gravity >= @gravity_max
                @jump_count = 1 if @jump_count > 1
                @dymovement = -@gravity
            elsif is_grounded? && @jump == 0
                @jump_count = @jump_count_max
                @gravity = 0
                @dymovement = 0
            end

            if @jump != 0
                @gravity = 0
            end
        end

        def move_jump_by(amount)
            @gravity = 0
            @dymovement = 0
            move_y(amount)
        end

        def move_x(amount, on_collide = nil)
            @xremainder += amount
            move = @xremainder.round()
            if move != 0
                @xremainder -= move
                sign = move.sign
                while move != 0
                    if !collide_at([@x + sign, @y])
                        @x += sign
                        move -= sign
                    else
                        if on_collide != nil
                            on_collide
                        end
                        break
                    end
                end
            end
        end

        def move_y(amount, on_collide = nil)
            @yremainder += amount
            move = @yremainder.round()
            if move != 0
                @yremainder -= move
                sign = move.sign
                while move != 0
                    if !collide_at([@x, @y + sign])
                        @y += sign
                        move -= sign
                    else
                        if on_collide != nil
                            on_collide
                        end
                        break
                    end
                end
            end
        end

        def move_input_left_right
            @dxmovement = 1 * @speed if Globals::Inputs.right
            @dxmovement = -1 * @speed if Globals::Inputs.left
            @dxmovement = 0 if !Globals::Inputs.right && !Globals::Inputs.left
        end

        def move_inside_wall
            @level.collision_blocks.each do |block|
                if Globals.geometry.intersect_rect?(block, {
                    x: hitbox.x,
                    y: hitbox.y,
                    w: hitbox.w,
                    h: hitbox.h})
                    block_center = [block.x + block.w / 2, block.y + block.h / 2]
                    player_center = [hitbox.x + hitbox.w / 2, hitbox.y + hitbox.h / 2]
                    if player_center.y > block_center.y
                        move_y(1)
                    elsif player_center.y < block_center.y
                        move_y(-1)
                    end

                    if player_center.x > block_center.x
                        move_x(1)
                    elsif player_center.x < block_center.x
                        move_x(-1)
                    end
                end
            end

        end

        def move_move
            @dx = @dxmovement
            @dy = @dymovement
            # @dy = -1

            move_x(@dx)
            move_y(@dy)
            # @y += @dy
        end

        def move
            move_input_left_right
            move_jump
            move_gravity
            move_move
            move_inside_wall
        end

        ##########
        # MAIN
        ##########

        def update
            super
            return if is_dead?
            move
        end

        def draw
            super
            return if is_dead?
            animation
            Globals.outputs.debug << "#{@jump_count}"
            Globals.outputs[:batch].sprites << self
        end

        ###########
        # UTILS
        ###########

        def has_cheese?
            if @cheese_status == :ungrabbed
                return false
            elsif @cheese_status == :grabbed
                return true
            else
                return false
            end
        end

        def give_cheese
            @cheese_status = :grabbed
        end

        def give_jump(val)
            @jump_count += val
        end

        def is_idle?
            if @dx == 0 && @dy == 0
                return true
            else
                return false
            end
        end

        def is_walking?
            if @dx != 0
                return true
            else
                return false
            end
        end

        def is_jumping?
            if @jump > 0
                return true
            else
                return false
            end
        end

        def is_falling?
            if @gravity > 0
                return true
            else
                return false
            end
        end

        def is_dead?
            @dead_status
        end

        def kill
            @dead_status = true
        end

        def revive
            @dead_status = false
        end

        def is_safe?
            @level.safe_blocks.any? do |block|
                Globals.geometry.intersect_rect?(block, hitbox)
            end
        end
        
        def collide_at(pos)
            @level.collision_blocks.any? do |block|
                Globals.geometry.intersect_rect?(block, {
                    x: pos.x,
                    y: pos.y,
                    w: hitbox.w,
                    h: hitbox.h
                })
            end
        end

        def is_grounded?
            @level.collision_blocks.any? do |block|
                Globals.geometry.intersect_rect?(block, {
                    x: hitbox.x,
                    y: hitbox.y - 1,
                    w: hitbox.w,
                    h: hitbox.h
                })
            end
        end
        
        def hitbox
            {
                x: @x + 1,
                y: @y,
                w: @w - 2,
                h: @h / 2
            }
        end

    end
end