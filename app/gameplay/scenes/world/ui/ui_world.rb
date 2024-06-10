module RatGame
    class UiWorld
        def initialize
            @deathui = UiWorldDeath.new
            @cat_timerui = UiWorldCatTimer.new
            @cheese_hud = UiWorldCheeseHud.new
            @win = UiWorldWin.new
        end

        def win
            @win
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
            @win.update
        end

        def draw
            @cat_timerui.draw
            @deathui.draw
            @cheese_hud.draw
            @win.draw
        end
    end
end