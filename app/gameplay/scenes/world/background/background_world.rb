module RatGame
    class BackgroundWorld
        def initialize
            @cat = BackgroundWorldCat.new
            @cat_red = BackgroundWorldCatRed.new
            @bg = BackgroundWorldBG.new
        end

        def cat
            @cat
        end

        def cat_red
            @cat_red
        end

        def bg
            @bg
        end

        def update
            bg.update
            cat.update
            cat_red.update
        end

        def draw
            bg.draw
            cat.draw
            cat_red.draw
        end
    end
end