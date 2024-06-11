module RatGame
    class GroundWorldBackground
        def initialize
            @timer = 0
            @timer_max = 60
            @status = false
        end

        def mouse
            Globals.state.scene.world.mouse
        end

        def debug_text
            {
                x: 120,
                y: 90,
                text: "You died",
                r: 255,
                g: 255,
                b: 255,
                primitive_marker: :label
            }
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
        end

        def draw
            if @status == true
                Globals.outputs[:batch_ui].primitives << foreground
                Globals.outputs[:batch_ui].primitives << debug_text
                
            end
        end
    end
end