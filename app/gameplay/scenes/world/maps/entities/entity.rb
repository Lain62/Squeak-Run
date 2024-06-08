module RatGame
    class Entity < Solids
        def initialize(data)
            @x = data.x
            @y = data.y
            @w = data.width
            @h = data.height
        end

        def update
            super
        end

        def draw
            super
        end
    end
end