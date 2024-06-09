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
            @cat_timerui.update
            @deathui.update
            
        end

        def draw
            @cat_timerui.draw
            @deathui.draw
        end
    end
end