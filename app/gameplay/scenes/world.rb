module RatGame
    class SceneWorld
        def initialize

            @maps = Maps.new()
        end

        def update
            @maps.update
        end

        def draw
            @maps.draw
        end
    end
end