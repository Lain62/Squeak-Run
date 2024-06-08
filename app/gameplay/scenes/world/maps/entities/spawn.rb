module RatGame
    class Spawn < EntityWithSprites
        def initialize(data)
            super(data)
        end

        def update
            super
            if Globals::State.mouse == nil
                Globals::State.mouse = Mouse.new(@x, @y)
            end
        end

        def draw
            super
            Globals.outputs[:batch].sprites << self
        end
    end
end