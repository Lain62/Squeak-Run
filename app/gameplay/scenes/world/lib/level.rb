module RatGame
    class Level
        attr_accessor :mouse, :collision_blocks, :safe_blocks, :entities
        def initialize(path)
            @data = Drogmo::Level.new(Globals.state.project.ogmo, path)
            @load_status = false
            @mouse = nil
            @collision_blocks = []
            @safe_blocks = []
            @entities = []
        end

        def loaded?
            @load_status
        end

        def load_layer_object
            @data.layers["object"].entities.each do |object|
                case object.name
                when "spawn"
                    @entities << Spawn.new(object, self)
                end
            end
        end

        def load_layer_collision_blocks
            @data.layers["collision_blocks"].sprites.each do |object|
                @collision_blocks << Collision.new(object)
            end
        end

        def unload
            @load_status = false
        end

        def load
            @load_status = true
            load_layer_object
            load_layer_collision_blocks
        end
    end
end