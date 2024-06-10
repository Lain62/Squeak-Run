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
                    w: 320,
                    h: 180,
                    primitive_marker: :solid,
                    r: 0,
                    g: 0,
                    b: 0
                },
                {
                    x: 320,
                    y: 0,
                    text: "loading",
                    primitive_marker: :label,
                    size_enum: 1,
                    alignment_enum: 2,
                    vertical_alignment_enum: 0,
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