module RatGame
    class UiWorldWin
        def initialize
        end

        def world
            Globals.state.scene.world
        end

        def debug_text
            {
                x: 120,
                y: 90,
                text: "You win",
                r: 255,
                g: 255,
                b: 255,
                primitive_marker: :label
            }
        end
        def debug_text_2
            {
                x: 0,
                y: 100,
                text: "#{world.timer / 60}s",
                r: 255,
                g: 255,
                b: 255,
                primitive_marker: :label
            }
        end

        def foreground
            {
                x: 0,
                y: 0,
                w: 320,
                h: 180,
                primitive_marker: :solid
            }
        end

        def update
            return if world.win != :true

            if Globals::Inputs.a_down
                Globals.state.scene.manager.change_scene(:level_menu)
            end
        end


        def draw
            if world.win == :true
                Globals.outputs[:ui].primitives << foreground
                Globals.outputs[:ui].primitives << debug_text
                Globals.outputs[:ui].primitives << debug_text_2
            end
        end
    end
end