module RatGame
    class Scenes
        attr_accessor :current_scene, :width, :height
        def initialize
            @current_scene = :world
            @width = 320
            @height = 180
            @scene_world = SceneWorld.new()
            Globals::State.scene_x = 0
            Globals::State.scene_y = 0
            Globals::State.scene_width = 1280
            Globals::State.scene_height = 720
        end

        def update
            case @current_scene
            when :world then @scene_world.update
            end
        end

        def draw
            case @current_scene
            when :world then @scene_world.draw
            end

            Globals.outputs[:batch].transient!
            Globals.outputs[:batch].w = @width
            Globals.outputs[:batch].h = @height

            Globals.outputs.sprites << {
                x: Globals::State.scene_x,
                y: Globals::State.scene_y,
                w: Globals::State.scene_width,
                h: Globals::State.scene_height,
                path: :batch
            }
        end
    end
end