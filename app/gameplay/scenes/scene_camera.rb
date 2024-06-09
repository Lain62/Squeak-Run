module RatGame
    class SceneCamera
        def initialize
            @follow_x = 0
            @follow_y = 0
        end
        def x
            return 0 if Globals.state.scene.manager.current_scene != :world

            center = ((Globals.state.scene.world.mouse.x - 320 / 2) * -4)
            mouse = ((Globals.state.scene.world.mouse.x) * -4)
            if @follow_x != center 
                @follow_x += (center - @follow_x) / 8
            end

            if @follow_x > 0
                @follow_x = 0
            elsif @follow_x - 1280 < -w * 4
                @follow_x = -w * 4 + 1280
            end

            
            @follow_x.to_i
        end

        def y
            # 2 * 4 to compensate for 180 res not being able to be divided by 16
            return 2 * 4 if Globals.state.scene.manager.current_scene != :world

            center = ((Globals.state.scene.world.mouse.y - 180 / 2) * -4)
            if @follow_y != center
                @follow_y += (center - @follow_y) / 8
            end

            if @follow_y > 2*4
                @follow_y = 2*4
            elsif @follow_y - 720 + 2*4 < -h * 4 + 2*4
                @follow_y = -h * 4 + 720 - 2*4
            end
            @follow_y.to_i
        end

        def w
            return 320 if Globals.state.scene.manager.current_scene != :world

            Globals.state.scene.world.width
        end

        def h
            return 180 if Globals.state.scene.manager.current_scene != :world

            Globals.state.scene.world.height
        end
    end
end