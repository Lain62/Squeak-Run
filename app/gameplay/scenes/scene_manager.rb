module RatGame
    class SceneManager
        attr_accessor :current_scene, :width, :height
        def initialize
            @current_scene = :world
            @width = 320
            @height = 180
            Globals.state.scene.world = SceneWorld.new()
            Globals.state.scene.x = 0
            Globals.state.scene.y = 0
            Globals.state.scene.width = 1280
            Globals.state.scene.height = 720
        end

        def update
            case @current_scene
            when :world then Globals.state.scene.world.update
            end
        end

        def draw
            Globals.outputs[:batch].transient!
            Globals.outputs[:batch].w = @width
            Globals.outputs[:batch].h = @height

            case @current_scene
            when :world then Globals.state.scene.world.draw
            end

            Globals.outputs.sprites << {
                x: Globals.state.scene.x,
                y: Globals.state.scene.y,
                w: Globals.state.scene.width,
                h: Globals.state.scene.height,
                path: :batch
            }
        end
    end
end