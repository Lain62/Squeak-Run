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

        end

        def update
            super
            if @level.mouse == nil
                @level.mouse = Mouse.new(@x, @y, @level)
            end
        end

        def draw
            super
            Globals.outputs[:batch].sprites << self
            
        end
    end
end