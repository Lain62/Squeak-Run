module RatGame
    class Maps
        attr_accessor :maps
        def initialize
            ogmo = Globals::State.ogmo
            @maps = {
                "test_level"=> Map.new(Drogmo::Level.new(ogmo, "content/levels/test_level.json"))
            }
            @current_level = "test_level"
        end

        def update
            @maps[@current_level].update
        end

        def draw
            @maps[@current_level].draw
        end
    end
end