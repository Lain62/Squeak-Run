module RatGame
    class UiWorld
        def initialize
            @deathui = UiWorldDeath.new
            @cat_timerui = UiWorldCatTimer.new
            @cheese_hud = UiWorldCheeseHud.new
        end

        def cat_timer
            @cat_timerui
        end

        def death
            @deathui
        end

        def cheese_hud
            @cheese_hud
        end


        def update
            @cat_timerui.update
            @deathui.update
            @cheese_hud.update
        end

        def draw
            @cat_timerui.draw
            @deathui.draw
            @cheese_hud.draw
        end
    end
end