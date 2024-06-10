module RatGame
    class Level
        attr_accessor :mouse, :collision_blocks, :safe_blocks, :entities, :width, :height, :cat_timer, :hazard_blocks, :win
        def initialize(path)
            @data = Drogmo::Level.new(Globals.state.project.ogmo, path)
            @load_status = false
            @mouse = nil
            @collision_blocks = []
            @safe_blocks = []
            @entities = []
            @hazard_blocks = []
            @cat_timer = nil
            @width = 0
            @height = 0
            @win = false
        end

        def loaded?
            @load_status
        end

        def load_cat_timer
            @cat_timer = CatTimer.new(self)
        end

        def load_layer_safe_blocks
            @data.layers["safe_blocks"].sprites.each do |object|
                @safe_blocks << Safe.new(object)
            end
        end

        def load_layer_object
            @data.layers["object"].entities.each do |object|
                case object.name
                when "spawn"
                    @entities << Spawn.new(object, self)
                when "spring"
                    @entities << Spring.new(object, self)
                when "cheese"
                    @entities << Cheese.new(object, self)
                when "flag"
                    @entities << Flag.new(object, self, @entities.length)
                end
            end
        end

        def load_layer_collision_blocks
            @data.layers["collision_blocks"].sprites.each do |object|
                @collision_blocks << Collision.new(object)
            end
        end

        def load_layer_hazard_blocks
            @data.layers["hazard_blocks"].sprites.each do |object|
                @hazard_blocks << Hazard.new(object)
            end
        end

        def load_width_height
            @width = @data.width
            @height = @data.height
        end

        def unload
            @load_status = false
        end

        def load
            @load_status = true
            load_width_height
            load_layer_object
            load_layer_safe_blocks
            load_layer_collision_blocks
            load_layer_hazard_blocks
            load_cat_timer
        end
    end
end