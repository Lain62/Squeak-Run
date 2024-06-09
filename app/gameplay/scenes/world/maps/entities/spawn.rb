module RatGame
    class Spawn < EntityWithSprites
        def initialize(data)
            super(data)
            @path = Globals.atlas
            @tile_x = 0
            @tile_y = 8 * 16
            @tile_w = 16
            @tile_h = 16
        end

        def update
            super
            if Globals::State.mouse == nil
                Globals::State.mouse = Mouse.new(@x, @y)
            end
        end

        def draw
            super
            Globals.outputs[:batch].sprites << self
        end
    end
end