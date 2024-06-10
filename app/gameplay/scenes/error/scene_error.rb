module RatGame
    class SceneError
        def initialize
            @current_index = 0
        end

        def update
            if Globals::Inputs.a_down
                Globals.state.scene.manager.change_scene(:level_menu)
            end
        end

        def draw
            Globals.outputs[:ui].solids << {
                x: 140, 
                y: 90,
                w: 320,
                h: 180,
                r: 250,
                g: 250,
                b: 250
            }
            Globals.outputs[:ui].labels << {
                x: 140, 
                y: 90,
                text: "Error, you are not supposed to be here",
                size_enum: 1
            }
            Globals.outputs[:ui].labels << {
                x: 140, 
                y: 80,
                text: "Press J / Z / SPACE to go back to main menu",
                size_enum: 1
            }
        end
    end
end