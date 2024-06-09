module RatGame
    class UiWorldDeath
        def initialize
            @timer = 0
            @timer_max = 60
            @status = false
        end

        def mouse
            Globals.state.scene.world.mouse
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

        def start
            if @status == false
                @timer = @timer_max
                @status = true
            end
        end

        def is_shown?
            @status
        end

        def time
            @timer
        end

        def timer_update
            if @timer == 0
                @status = false
            end
            
            if @timer > 0
                @timer -= 1
            end
        end

        def check_mouse
            return if mouse == nil

            if mouse.is_dead?
                start
            end
        end

        def update
            timer_update
            check_mouse

            puts @status
        end

        def draw
            if @status == true
                Globals.outputs[:ui].primitives << foreground
            end
        end
    end
end