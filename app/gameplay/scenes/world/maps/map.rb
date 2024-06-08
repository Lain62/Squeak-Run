module RatGame
    class Map
        attr_reader :data
        def initialize(data)
            @data = data
            @entities = []
            @collision_blocks = []
            @safe_blocks = []
            
            @data.layers["object"].entities.each do |entity|
                case entity.name
                when "spawn" 
                    @entities << Spawn.new(entity)
                when "cheese"
                    @entities << Cheese.new(entity)
                end
            end

            @data.layers["collision_blocks"].sprites.each do |sprite|
                @collision_blocks << Collision.new(sprite)
            end

            @data.layers["safe_blocks"].sprites.each do |sprite|
                @safe_blocks << Safe.new(sprite)
            end
        end

        def mouse
            Globals::State.mouse
        end

        def mouse_collision_check
            return if mouse == nil

            if mouse.collision_blocks.length != @collision_blocks.length
                mouse.collision_blocks = @collision_blocks
            end
        end
        
        
        def update
            mouse_collision_check
            @entities.each do |entity|
                entity.update if entity.respond_to?(:update)
            end

            @collision_blocks.each do |collision|
                collision.update if collision.respond_to?(:update)
            end

            @safe_blocks.each do |safe|
                safe.update if safe.respond_to?(:update)
            end

            mouse.update if mouse.respond_to?(:update)
        end

        def draw
            Globals.outputs[:batch].sprites << @data.layers["background"].sprites
            @entities.each do |entity|
                entity.draw if entity.respond_to?(:draw)
            end

            @collision_blocks.each do |collision|
                collision.draw if collision.respond_to?(:draw)
            end

            @safe_blocks.each do |safe|
                safe.draw if safe.respond_to?(:draw)
            end

            mouse.draw if mouse.respond_to?(:draw)
        end
    end
end