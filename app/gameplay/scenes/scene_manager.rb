module RatGame
    class SceneManager
        attr_accessor :current_scene, :width, :height, :loaded
        def initialize
            @current_scene = :level_menu
            @loaded = false
            
            Globals.state.scene.camera = SceneCamera.new()
            Globals.state.scene.world = SceneWorld.new()
            Globals.state.scene.level_menu = SceneLevelMenu.new
            Globals.state.scene.transition = SceneTransition.new
            Globals.state.scene.error = SceneError.new
        end

        def change_scene(val)
            @loaded = false
            @current_scene = :transition
            Globals.state.scene.transition.start_transition(val) if Globals.state.scene.transition.status != :start
        end

        def update
            @loaded = true
            case @current_scene
            when :world then Globals.state.scene.world.update
            when :level_menu then Globals.state.scene.level_menu.update
            when :transition then Globals.state.scene.transition.update
            else
                Globals.state.scene.error.update
            end

            
        end

        def draw
            return if @loaded == false
            Globals.outputs[:batch].transient!
            Globals.outputs[:batch].w = Globals.state.scene.camera.w
            Globals.outputs[:batch].h = Globals.state.scene.camera.h

            Globals.outputs[:ui].transient!
            Globals.outputs[:ui].w = 320
            Globals.outputs[:ui].h = 180
            
            case @current_scene
            when :world then Globals.state.scene.world.draw
            when :level_menu then Globals.state.scene.level_menu.draw
            when :transition then Globals.state.scene.transition.draw
            else
                Globals.state.scene.error.draw
            end



            

            Globals.outputs.sprites << {
                x: Globals.state.scene.camera.x,
                y: Globals.state.scene.camera.y,
                w: Globals.state.scene.camera.w * 4,
                h: Globals.state.scene.camera.h * 4,
                path: :batch
            }

            Globals.outputs.sprites << {
                x: 0,
                y: 0,
                w: 320 * 4,
                h: 180 * 4,
                path: :ui
            }
        end
    end
end