module RatGame
    class Solids
        attr_accessor :x, :y, :w, :h, :r, :g, :b, :a, :anchor_x, :anchor_y, :blendmode_enum
      
        def primitive_marker
          :solid
        end

        def update
        end

        def draw
        end
    end
end