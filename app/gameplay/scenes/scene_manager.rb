module RatGame
    class SceneManager
        attr_accessor :current_scene, :width, :height
        def initialize
            @current_scene = :world
            
            Globals.state.scene.camera = SceneCamera.new()
            Globals.state.scene.world = SceneWorld.new()
        end

        def update
            case @current_scene
            when :world then Globals.state.scene.world.update
            end
        end

        def draw
            Globals.outputs[:batch].transient!
            Globals.outputs[:batch].w = Globals.state.scene.camera.w
            Globals.outputs[:batch].h = Globals.state.scene.camera.h
            case @current_scene
            when :world then Globals.state.scene.world.draw
            end

            Globals.outputs.sprites << {
                x: Globals.state.scene.camera.x,
                y: Globals.state.scene.camera.y,
                w: Globals.state.scene.camera.w * 4,
                h: Globals.state.scene.camera.h * 4,
                path: :batch
            }
        end
    end
end