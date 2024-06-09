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
                tile_y: 14 * 16,
                tile_w: 16,
                tile_h: 16,
                primitive_marker: :sprite
                
            }
        end

        def background
            {
                x: 320 / 2 - 16 * 2,
                y: 160,
                w: 16 * 4,
                h: 16,
                path: Globals.atlas,
                tile_x: 0,
                tile_y: 13 * 16,
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
            Globals.outputs[:ui].primitives << background
            Globals.outputs[:ui].primitives << foreground
        end
    end
end