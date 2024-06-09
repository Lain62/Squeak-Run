module RatGame
    class EntityWithSprites < Sprites
        def initialize(data)
            @x = data.x
            @y = data.y
            @w = data.width
            @h = data.height
            @path = data.data.texture_path
        end

        def update

        end

        def draw

        end
    end
end