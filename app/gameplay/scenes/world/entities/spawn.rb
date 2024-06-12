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

            @animation_status = :stop
            @animation = 0
            @animation_interval = 10
            @animation_frame = 0
            @animation_frame_max = 7
        end

        def ui
            Globals.state.scene.world.ui
        end

        def update
            super
            if @level.mouse == nil
                @level.mouse = Mouse.new(@x, @y, @level)
            end

            return if @level.mouse == nil

            if @level.mouse.is_dead? && @level.mouse.spawn_point == 0
                if ui.death.time == 1
                    @level.mouse.x = @x
                    @level.mouse.y = @y
                    @level.mouse.revive
                end
            end

            if Globals.geometry.intersect_rect?(self, @level.mouse) && @level.mouse.has_cheese?
                @animation_status = :start
                @level.win = :rising
            end

            if @animation_status == :start
                @animation += 1
            end

            if @animation >= @animation_interval && @animation_frame < @animation_frame_max
                @animation = 0
                @animation_frame += 1
            end

            if @animation_status == :start
                @tile_x = @animation_frame * 16 + 16
            end

            if @animation_frame == 5
                Globals.outputs.sounds << "content/sounds/flag.wav"
            end

            if @animation_frame == @animation_frame_max

                @level.win = :true
            end
        end

        def draw
            super
            Globals.outputs[:batch].sprites << self
            
        end
    end
end