module RatGame
    class Cheese < EntityWithSprites
        def initialize(data, level)
            super(data)
            @level = level
            @path = Globals.atlas
            @tile_x = 0
            @tile_y = 11 * 16
            @tile_w = 16
            @tile_h = 16

            @animation_idle = 0
            @animation_idle_interval = 14
            @animation_idle_frame = 0
            @animation_idle_frame_max = 5
        end

        def animation
            @animation_idle += 1

            if @animation_idle >= @animation_idle_interval
                @animation_idle = 0
                @animation_idle_frame += 1
            end

            if @animation_idle_frame >= @animation_idle_frame_max
                @animation_idle_frame = 0
            end

            @tile_x = @animation_idle_frame * 16
        end

        def update
            super
            
        end

        def draw
            super
            animation
            Globals.outputs[:batch].sprites << self
        end
    end
end