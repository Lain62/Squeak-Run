module RatGame
    class Collision < Sprites
        def initialize(data)
            @x = data.x
            @y = data.y
            @w = data.w
            @h = data.h
            @path = data.path
            @tile_x = data.tile_x
            @tile_y = data.tile_y
            @tile_w = data.tile_w
            @tile_h = data.tile_h
        end

        def update
            super
        end

        def draw
            super
            Globals.outputs[:batch].sprites << self
        end
    end
end