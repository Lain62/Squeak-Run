module RatGame
    class SceneTransition
        attr_reader :status
        attr_accessor :next_scene
        def initialize
            @timer_max = 180
            @timer_min = -180
            @speed = 20
            @timer = @timer_min
            @status = :stop
            @next_scene = :none
        end

        def start_transition(val)
            @status = :start
            @timer = @timer_min
            @next_scene = val
        end

        def update
            return if @status != :start

            if @timer <= @timer_max
                @timer += @speed
            end

            if @timer >= @timer_max
                @status = :finish
                Globals.state.scene.manager.loaded = false
                Globals.state.scene.manager.current_scene = @next_scene
            end
        end

        def sprites
            [
                {
                    x: 0,
                    y: 0,
                    w: 1280,
                    h: 720,
                    primitive_marker: :solid,
                    r: 0,
                    g: 0,
                    b: 0
                },
                {
                    x: 1280 / 2,
                    y: 720 / 2,
                    text: "LOADING",
                    primitive_marker: :label,
                    size_enum: 1,
                    alignment_enum: 1,
                    vertical_alignment_enum: 1,
                    size_enum: 4,
                    font: "content/fonts/Pixeled.ttf",
                    r: 250,
                    g: 250,
                    b: 250,
                }
            ]
        end

        def draw
            Globals.outputs[:ui].primitives << sprites
        end
    end
end