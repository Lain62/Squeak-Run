class Numeric
    def sign
      if self > 0
        1
      elsif zero?
        0
      else
        -1
      end
    end
end  

module RatGame
    class Globals
        def self.atlas
            "content/sprites/squeakrunbranmomentyay.png"
        end

        def self.outputs
            $args.outputs
        end

        def self.state
            $args.state
        end

        def self.inputs
            $args.inputs
        end

        def self.geometry
            $args.geometry
        end

        def self.audio
            $args.audio
        end

        class Inputs
            def self.left
                $args.inputs.keyboard.key_down.left_arrow || $args.inputs.keyboard.key_down.a || $args.inputs.keyboard.key_held.left_arrow || $args.inputs.keyboard.key_held.a
            end

            def self.right
                $args.inputs.keyboard.key_down.right_arrow || $args.inputs.keyboard.key_down.d || $args.inputs.keyboard.key_held.right_arrow || $args.inputs.keyboard.key_held.d
            end

            def self.up
                $args.inputs.keyboard.key_down.up_arrow || $args.inputs.keyboard.key_down.w || $args.inputs.keyboard.key_held.up_arrow || $args.inputs.keyboard.key_held.w
            end

            def self.down
                $args.inputs.keyboard.key_down.down_arrow || $args.inputs.keyboard.key_down.s || $args.inputs.keyboard.key_held.down_arrow || $args.inputs.keyboard.key_held.s
            end

            def self.left_down
                $args.inputs.keyboard.key_down.left_arrow || $args.inputs.keyboard.key_down.a 
            end

            def self.right_down
                $args.inputs.keyboard.key_down.right_arrow || $args.inputs.keyboard.key_down.d 
            end

            def self.up_down
                $args.inputs.keyboard.key_down.up_arrow || $args.inputs.keyboard.key_down.w 
            end

            def self.down_down
                $args.inputs.keyboard.key_down.down_arrow || $args.inputs.keyboard.key_down.s 
            end

            def self.a
                $args.inputs.keyboard.key_down.z || $args.inputs.keyboard.key_down.j || $args.inputs.keyboard.key_down.space || $args.inputs.keyboard.key_held.z || $args.inputs.keyboard.key_held.j || $args.inputs.keyboard.key_held.space 
            end

            def self.a_down
                $args.inputs.keyboard.key_down.z || $args.inputs.keyboard.key_down.j || $args.inputs.keyboard.key_down.space 
            end

            def self.b
                $args.inputs.keyboard.key_down.x || $args.inputs.keyboard.key_down.k || $args.inputs.keyboard.key_down.escape || $args.inputs.keyboard.key_held.x || $args.inputs.keyboard.key_held.k || $args.inputs.keyboard.key_held.escape
            end

            def self.b_down
                $args.inputs.keyboard.key_down.x || $args.inputs.keyboard.key_down.k || $args.inputs.keyboard.key_down.escape
            end
        end
    end
end