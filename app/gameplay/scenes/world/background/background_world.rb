module RatGame
    class BackgroundWorld
        def initialize
            @cat = BackgroundWorldCat.new
            @cat_red = BackgroundWorldCatRed.new
        end

        def cat
            @cat
        end

        def cat_red
            @cat_red
        end

        def update
            cat.update
            cat_red.update
        end

        def draw
            cat.draw
            cat_red.draw
        end
    end
end