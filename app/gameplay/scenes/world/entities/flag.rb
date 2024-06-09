module RatGame
    class Flag < EntityWithSprites
        def initialize(data, level)
            super(data)
            @level = level
            @path = Globals.atlas
            @tile_x = 0
            @tile_y = 11 * 16
            @tile_w = 16
            @tile_h = 16
        end

        def animation
        end

        def update
        end

        def draw
            super
            animation
            Globals.outputs[:batch].sprites << self
        end
    end
end