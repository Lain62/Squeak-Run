module RatGame
    class Cheese < EntityWithSprites
        def initialize(data)
            super(data)
        end

        def update
            super
        end

        def draw
            super
            Globals.outputs[:batch].sprites << self
        end
    end
end