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
            Globals.outputs[:ui].solids << {
                x: 0,
                y: 0,
                w: 320,
                h: 180,
                r: 250,
                g: 250,
                b: 250
            }
            Globals.outputs[:ui].labels << {
                x: 140, 
                y: 90,
                text: "#{levels_list[@current_index].name}"
            }
        end
    end
end