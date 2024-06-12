module RatGame
    class BackgroundWorldCat
        def initialize
            @anim = 0
            @anim_interval = 6
            @anim_index = 0
            @anim_index_max = 19

        end

        def sprite
            {
                x: 0,
                y: 0,
                w: 320,
                h: 180,
                tile_x: @anim_index * 320,
                tile_y: 0,
                tile_w: 320,
                tile_h: 180,
                path: "content/images/uncannygato-sheet.png",
                primitive_marker: :sprite
            }
        end

        def update
            @anim += 1
            
            if @anim > @anim_interval
                @anim = 0
                @anim_index += 1
            end

            if @anim_index > @anim_index_max
                @anim_index = 0
            end
        end

        def draw
            Globals.outputs[:batch_background].primitives << sprite
        end
    end
end