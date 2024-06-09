module RatGame
    class UiWorld
        def initialize
            @deathui = UiWorldDeath.new
            @cat_timerui = UiWorldCatTimer.new
        end

        def cat_timer
            @cat_timerui
        end

        def death
            @deathui
        end


        def update
            @deathui.update
            @cat_timerui.update
        end

        def draw
            @deathui.draw
            @cat_timerui.draw
        end
    end
end