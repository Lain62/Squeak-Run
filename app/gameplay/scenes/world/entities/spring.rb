module RatGame
    class Spring < EntityWithSprites
        def initialize(data, level)
            super(data)
            @level = level
            @path = Globals.atlas
            @tile_x = 0
            @tile_y = 10 * 16
            @tile_w = 16
            @tile_h = 16
            @jump_timer = 0
            @jump_timer_max = 14

            @animation = 0
            @animation_interval = 2
            @animation_frame = 0
            @animation_frame_max = 7
            @animation_max = @animation_interval * @animation_frame_max
        end

        def hitbox
            {
                x: @x + 2,
                y: @y,
                w: 12,
                h: 4
            }
        end

        def update
            super
            if @level.mouse != nil
                if Globals.geometry.intersect_rect?(hitbox, @level.mouse)
                    Globals.outputs.sounds << "content/sounds/spring.wav"
                    @jump_timer = @jump_timer_max
                    @level.mouse.give_jump(1)
                    @animation = @animation_max
                    @animation_frame = 0
                end

                if @jump_timer > 0
                    @jump_timer -= 1
                    @level.mouse.move_jump_by(4)
                end
            end
        end

        def draw
            super
            if @animation > 0
                @animation -= 1

                if @animation % @animation_interval == 0
                    @animation_frame += 1
                end
    
                if @animation_frame == @animation_frame_max
                    @animation_frame = 0
                end
    
                @tile_x = @animation_frame * 16
            end
            Globals.outputs[:batch].sprites << self
        end
    end
end