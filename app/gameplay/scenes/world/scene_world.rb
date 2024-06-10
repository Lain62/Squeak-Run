module RatGame
    class SceneWorld
        def initialize
            @current_level_id = :test_level
            @levels = {
                test_level: Level.new("content/levels/test_level.json")
            }
            @ui = UiWorld.new
        end

        def ui
            @ui
        end

        def cat_timer_controller
            return if !current_level.loaded?
            return if mouse == nil

            if mouse.is_safe?
                cat_timer.rise
            elsif mouse.is_dead?
                cat_timer.reset
            else
                cat_timer.start
            end

            if cat_timer.time == 1
                mouse.kill
            end

            cat_timer.update
        end

        def hazard_controller
            return if !current_level.loaded?
            return if mouse == nil
            return if hazard_blocks == []

            dieded = hazard_blocks.any? do |block|
                Globals.geometry.intersect_rect?(block, mouse)
            end

            if dieded
                mouse.kill
            end
        end

        def win?
            return nil if !current_level.loaded?

            return current_level.win
        end

        def win=(val)
            return nil if !current_level.loaded?

            current_level.win = val
        end

        def cat_timer
            if current_level.loaded?
                current_level.cat_timer
            else
                nil
            end
        end

        def width
            if current_level.loaded?
                current_level.width
            else
                320
            end
        end

        def height
            if current_level.loaded?
                current_level.height
            else
                180
            end
        end

        def entities
            if current_level.loaded?
                current_level.entities
            else
                []
            end
        end

        def hazard_blocks
            if current_level.loaded?
                current_level.hazard_blocks
            else
                []
            end
        end

        def safe_blocks
            if current_level.loaded?
                current_level.safe_blocks
            else
                []
            end
        end

        def mouse
            if current_level.loaded?
                current_level.mouse
            else
                nil
            end
        end

        def collision_blocks
            if current_level.loaded?
                current_level.collision_blocks
            else
                []
            end
        end

        def current_level
            @levels[@current_level_id]
        end

        def change_level(level_id)
            if current_level.loaded?
                current_level.unload
                @current_level_id = level_id
            end
        end

        def load_current_level
            if !current_level.loaded?
                current_level.load
            end
        end

        def update
            if !current_level.loaded?
                load_current_level
            end

            ui.update
            if current_level.loaded?
                
                hazard_controller
                cat_timer_controller
            
                entities.each do |entity|
                    entity.update
                end
    
                mouse.update if mouse != nil && !win?
            end

        end

        def draw
            ui.draw
            if current_level.loaded?
                entities.each do |entity|
                    entity.draw
                end
    
                safe_blocks.each do |block|
                    block.draw
                end
    
                collision_blocks.each do |block|
                    block.draw
                end
    
                mouse.draw if mouse != nil && !win?
            end
            
        end
    end
end