module RatGame
    class Flag < EntityWithSprites
        def initialize(data, level, flag_number)
            super(data)
            @flag_number = flag_number
            @level = level
            @path = Globals.atlas
            @tile_x = 0
            @tile_y = 9 * 16
            @tile_w = 16
            @tile_h = 16
        end

        def ui
            Globals.state.scene.world.ui
        end

        def animation
        end

        def update
            return if @level.mouse == nil

            if Globals.geometry.intersect_rect?(self, @level.mouse)
                @level.mouse.spawn_point = @flag_number
            end

            if @level.mouse.is_dead? && @level.mouse.spawn_point == @flag_number
                if ui.death.time == 1
                    @level.mouse.x = @x
                    @level.mouse.y = @y
                    @level.mouse.revive
                end
            end
        end

        def draw
            super
            animation
            Globals.outputs[:batch].sprites << self
        end
    end
end