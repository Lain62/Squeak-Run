module RatGame
    class BackgroundWorldBG
        def initialize
        end

        def sprite
            {
                x: 0,
                y: 0,
                w: 320,
                h: 180,
                path: "content/images/background.png",
                primitive_marker: :sprite
            }
        end

        def update
        end

        def draw
            Globals.outputs[:batch_background].primitives << sprite
        end
    end
end