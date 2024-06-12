module RatGame
    class SceneLevelMenu
        def initialize
            @current_index = 0

            @anim_idle = 0
            @anim_idle_interval = 30
            @anim_idle_frame = 0
            @anim_idle_frame_max = 1

            @size = 80
        end

        def levels_list
            [
                {
                    name: "Level Test",
                    goto: :test_level
                },
                {
                    name: "Level 1",
                    goto: :test_level
                }
            ]
        end

        def update
            @anim_idle += 1

            if @anim_idle >= @anim_idle_interval
                @anim_idle = 0
                @anim_idle_frame += 1
            end

            if @anim_idle_frame > @anim_idle_frame_max
                @anim_idle_frame = 0
            end

            if Globals::Inputs.right_down
                Globals.outputs.sounds << "content/sounds/select.wav"
                @size = 85
                @current_index += 1 if @current_index < levels_list.length - 1
            end

            if Globals::Inputs.left_down
                Globals.outputs.sounds << "content/sounds/select.wav"
                @size = 85
                @current_index -= 1 if @current_index > 0
            end

            if Globals::Inputs.a_down
                Globals.outputs.sounds << "content/sounds/select.wav"
                Globals.state.scene.world.change_level(levels_list[@current_index].goto)
                Globals.state.scene.manager.change_scene(:world)
            end

            if @size > 80
                @size -= 1
            end
        end



        def draw
            Globals.outputs[:batch_ui].primitives << {
                x:0,
                y:0,
                w: 320,
                h: 180,
                path: "content/images/level-select-sheet.png",
                tile_x: @anim_idle_frame * 320,
                tile_y: 0,
                tile_w: 320,
                tile_h: 180,
                primitive_marker: :sprite
            }
            Globals.outputs[:ui].primitives << {
                x: 1280 / 2, 
                y: 380,
                size_enum: @size,
                alignment_enum: 1,
                vertical_alignment_enum: 1,
                text: "#{(levels_list[@current_index].name).upcase()}",
                font: "content/fonts/Pixeled.ttf",
                primitive_marker: :label,
                r:30,
                g:30,
                b:30
            }
        end
    end
end