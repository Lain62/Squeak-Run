module RatGame
    class Spawn < EntityWithSprites
        def initialize(data, level)
            super(data)
            @level = level
            @path = Globals.atlas
            @tile_x = 0
            @tile_y = 8 * 16
            @tile_w = 16
            @tile_h = 16
            @jump_timer = 0
            @jump_timer_max = 10
        end

        def update
            super
            if @level.mouse == nil
                @level.mouse = Mouse.new(@x, @y, @level)
            end

            if @level.mouse != nil
                if Globals.geometry.intersect_rect?(self, @level.mouse)
                    @jump_timer = @jump_timer_max
                end

                if @jump_timer > 0
                    @jump_timer -= 1
                    @level.mouse.move_jump_by(4)
                end
            end

        end

        def draw
            super
            Globals.outputs[:batch].sprites << self
            
        end
    end
end