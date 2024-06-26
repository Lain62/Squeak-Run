module RatGame
    class Sprites
        attr_accessor :x, :y, :w, :h, :path, :angle, :a, :r, :g, :b, :tile_x,
                    :tile_y, :tile_w, :tile_h, :flip_horizontally,
                    :flip_vertically, :angle_anchor_x, :angle_anchor_y, :id,
                    :angle_x, :angle_y, :z,
                    :source_x, :source_y, :source_w, :source_h, :blendmode_enum,
                    :source_x2, :source_y2, :source_x3, :source_y3, :x2, :y2, :x3, :y3,
                    :anchor_x, :anchor_y
        def initialize

        end

        def primitive_marker
            :sprite
        end

        def draw
        end

        def update
        end
    end
end