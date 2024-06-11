module RatGame
    class UiWorldWin
        def initialize
            @anim = -180
            @anim_max = 0

            @anim_idle = 0
            @anim_idle_interval = 30
            @anim_idle_frame = 0
            @anim_idle_frame_max = 1
        end

        def world
            Globals.state.scene.world
        end

        def timer
            {
                x: 230,
                y: @anim + 120,
                text: "#{(world.timer / 60).round(2)}s",
                r: 255,
                g: 255,
                b: 255,
                primitive_marker: :label,
                alignment_enum: 2,
                size_enum: 3,
                font: "content/fonts/Pixeled.ttf"
            }
        end

        def foreground
            {
                x: 0,
                y: @anim,
                w: 320,
                h: 180,
                path: "content/images/win-menu-sheet.png",
                primitive_marker: :sprite,
                tile_x: 320 * @anim_idle_frame,
                tile_y: 0,
                tile_w: 320,
                tile_h: 180,
            }
        end

        def update
            return if world.win != :true

            @anim += 3 if @anim <= @anim_max

            if @anim >= @anim_max
                @anim_idle += 1

                if @anim_idle >= @anim_idle_interval
                    @anim_idle = 0
                    @anim_idle_frame += 1
                end

                if @anim_idle_frame > @anim_idle_frame_max
                    @anim_idle_frame = 0
                end
            end

            if Globals::Inputs.a_down
                Globals.state.scene.manager.change_scene(:level_menu)
            end
        end


        def draw
            if world.win == :true
                Globals.outputs[:ui].primitives << foreground
                Globals.outputs[:ui].primitives << timer
            end
        end
    end
end