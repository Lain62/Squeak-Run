module RatGame
    class SceneAbout
        def initialize
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

            if Globals::Inputs.b_down
                Globals.outputs.sounds << "content/sounds/cancel.wav"
                Globals.state.scene.manager.change_scene(:main_menu)
            end
        end

        def sprites
            [
                {
                    x: 0,
                    y: 0 ,
                    w: 1280,
                    h: 720,
                    primitive_marker: :sprite,
                    path: "content/images/about.png"
                },
                {
                    x: 0,
                    y: 0 + @anim_idle_frame * 4,
                    w: 1280,
                    h: 720,
                    primitive_marker: :sprite,
                    path: "content/images/about.png"
                },
            ]
        end

        def draw
            Globals.outputs[:ui].primitives << sprites
        end
    end
end