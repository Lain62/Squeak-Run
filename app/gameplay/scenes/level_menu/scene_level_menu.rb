module RatGame
    class SceneLevelMenu
        def initialize
            @current_index = 0
        end

        def levels_list
            [
                {
                    name: "Level Test",
                    goto: :test_level
                }
            ]
        end

        def update
            if Globals::Inputs.a_down
                Globals.state.scene.world.change_level(levels_list[@current_index].goto)
                Globals.state.scene.manager.change_scene(:world)
            end
        end

        def draw
            Globals.outputs[:ui].primitives << {
                x:0,
                y:0,
                w: 320,
                h: 180,
                r: 250,
                g: 250,
                b: 250,
                primitive_marker: :solid
            }
            # Globals.outputs.primitives << {
            #     x: 0,
            #     y: 0,
            #     w: 1280,
            #     h: 720,
            #     r: 250,
            #     g: 250,
            #     b: 250,
            #     primitive_marker: :solid
            # }
            Globals.outputs.primitives << {
                x: 1280 / 2, 
                y: 720 / 2,
                size_enum: 5,
                alignment_enum: 1,
                vertical_alignment_enum: 1,
                text: "#{(levels_list[@current_index].name).upcase()}",
                font: "content/fonts/Pixeled.ttf",
                primitive_marker: :label
            }
        end
    end
end