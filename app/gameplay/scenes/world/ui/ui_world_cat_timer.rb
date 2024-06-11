module RatGame
    class UiWorldCatTimer
        def timer
            Globals.state.scene.world.cat_timer
        end

        def foreground
            {
                x: (320 / 2 - 16 * 2) + 16,
                y: 163,
                w: ( timer.time / 8).to_i,
                h: 10,
                path: Globals.atlas,
                tile_x: 0,
                tile_y: 15 * 16,
                tile_w: 16,
                tile_h: 16,
                primitive_marker: :sprite
                
            }
        end

        def background
            ycoords = 13 * 16
            if timer.time < timer.time_max / 4
                ycoords = 14 * 16
            end
            {
                x: 320 / 2 - 16 * 2,
                y: 160,
                w: 16 * 4,
                h: 16,
                path: Globals.atlas,
                tile_x: 0,
                tile_y: ycoords,
                tile_w: 16 * 4,
                tile_h: 16,
                primitive_marker: :sprite
            }
        end

        def timer
            Globals.state.scene.world.cat_timer
        end

        def update
            
        end

        def draw
            Globals.outputs[:batch_ui].primitives << background
            Globals.outputs[:batch_ui].primitives << foreground
        end
    end
end