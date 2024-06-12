module RatGame
    class BackgroundWorldCatRed
        def initialize
        end

        def timer
            Globals.state.scene.world.cat_timer
        end

        def test
            timer.time * 2.8
        end

        def test_2
            return 0 if timer.time > 90

            (252 - test).to_i
        end

        def sprite
            [
                {
                    x: 0,
                    y: 0,
                    w: 320,
                    h: 180,
                    primitive_marker: :solid,
                    a: test_2,
                    r: 0,
                    g: 0,
                    b: 0
                },
                {
                    x: 0,
                    y: 0,
                    w: 320,
                    h: 180,
                    tile_x: 0,
                    tile_y: 0,
                    tile_w: 320,
                    tile_h: 180,
                    path: "content/images/gatoevileyes.png",
                    primitive_marker: :sprite,
                    a: test_2,
                    r: test_2,
                    g: test_2,
                    b: test_2
                }
            ]
        end

        def update
            # Globals.outputs.debug << "#{(252 - test).to_i}"
        end

        def draw
            Globals.outputs[:batch_background].primitives << sprite
        end
    end
end