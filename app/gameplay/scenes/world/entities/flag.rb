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

            @animation = 0
            @animation_interval = 10
            @animation_frame = 0
            @animation_frame_max = 2
            @animation_status = :drop
        end

        def ui
            Globals.state.scene.world.ui
        end

        def animation
            @tile_x = @animation_frame * 16

            return if @animation_status == :rise

            if @animation_status == :rising
                @animation += 1
            end

            if @animation >= @animation_interval
                @animation = 0
                @animation_frame += 1
            end

            if @animation_frame >= @animation_frame_max
                @animation_status = :rise
            end
        end

        def update
            return if @level.mouse == nil

            if Globals.geometry.intersect_rect?(self, @level.mouse) && @level.mouse.spawn_point != @flag_number &&  @animation_status == :drop
                Globals.outputs.sounds << "content/sounds/flag.wav"
                @animation_status = :rising if @animation_status == :drop
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