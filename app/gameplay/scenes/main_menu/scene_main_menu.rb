module RatGame
    class SceneMainMenu
        def initialize
            @current_index = 1

            @anim_idle = 0
            @anim_idle_interval = 30
            @anim_idle_frame = 0
            @anim_idle_frame_max = 1
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

            if Globals::Inputs.down_down
                Globals.outputs.sounds << "content/sounds/select.wav"
                @current_index += 1 if @current_index < 4
            end

            if Globals::Inputs.up_down
                Globals.outputs.sounds << "content/sounds/select.wav"
                @current_index -= 1 if @current_index > 1
            end

            if Globals::Inputs.a_down
                Globals.outputs.sounds << "content/sounds/select.wav"
                case @current_index
                when 1 then Globals.state.scene.manager.change_scene(:level_menu)
                when 2 then Globals.state.scene.manager.change_scene(:tutorial)
                when 3 then Globals.state.scene.manager.change_scene(:about)
                when 4 then $args.gtk.request_quit
                end
            end

            if Globals::Inputs.b_down
                Globals.outputs.sounds << "content/sounds/cancel.wav"
            end

        end

        def draw
            Globals.outputs[:batch_ui].primitives << {
                x:0,
                y:0,
                w: 320,
                h: 180,
                r: 143,
                g: 86,
                b: 59,
                primitive_marker: :solid
            }
            Globals.outputs[:batch_ui].primitives << {
                x:0,
                y:0 + @anim_idle_frame,
                w: 320,
                h: 180,
                path: "content/images/main-menu-sheet.png",
                tile_x: @current_index * 320,
                tile_y: 0,
                tile_w: 320,
                tile_h: 180,
                primitive_marker: :sprite
            }
        end
    end
end