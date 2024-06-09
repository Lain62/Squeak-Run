module RatGame
    class SceneWorld
        def initialize
            @current_level_id = :test_level
            @levels = {
                test_level: Level.new("content/levels/test_level.json")
            }
        end

        def entities
            if current_level.loaded?
                current_level.entities
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
            load_current_level
            entities.each do |entity|
                entity.update
            end

            mouse.update if mouse != nil
        end

        def draw
            
            entities.each do |entity|
                entity.draw
            end

            collision_blocks.each do |block|
                block.draw
            end

            mouse.draw if mouse != nil
        end
    end
end