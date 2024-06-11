module RatGame
    class UiWorldCheeseHud
        def initialize
            @status = :no_cheese

            @timer = 0
            @timer_interval = 10
            @timer_index = 0
            @timer_index_max = 6
        end

        def mouse
            Globals.state.scene.world.mouse
        end

        def no_cheese_hud
            {
                x: 320 / 2 - 16 / 2,
                y: 160 - 16,
                w: 16,
                h: 16,
                path: Globals.atlas,
                tile_x: 1 * 16,
                tile_y: 15 * 16,
                tile_w: 16,
                tile_h: 16,
                primitive_marker: :sprite
            }
        end
    
        def cheese_get_hud
            {
                x: 320 / 2 - (16 * 3 / 2),
                y: 160 - 16,
                w: 16 * 3,
                h: 16,
                path: Globals.atlas,
                tile_x: 2 * 16,
                tile_y: 15 * 16,
                tile_w: 16 * 3,
                tile_h: 16,
                primitive_marker: :sprite
            }
        end
    
        def with_cheese_hud
            {
                x: 320 / 2 - 16 / 2,
                y: 160 - 16,
                w: 16,
                h: 16,
                path: Globals.atlas,
                tile_x: 2 * 16,
                tile_y: 15 * 16,
                tile_w: 16,
                tile_h: 16,
                primitive_marker: :sprite
            }
        end

        def update
            return if mouse == nil
            if mouse.has_cheese? && @status == :no_cheese
                @status = :cheese_get
            end

            if @status == :cheese_get
                @timer += 1
            end

            if @timer >= @timer_interval
                @timer = 0
                @timer_index += 1
            end

            if @timer_index >= @timer_index_max
                @status = :with_cheese
            end

        end

        def draw
            case @status
            when :no_cheese
                Globals.outputs[:batch_ui].primitives << no_cheese_hud
            when :cheese_get
                Globals.outputs[:batch_ui].primitives << cheese_get_hud
            when :with_cheese
                Globals.outputs[:batch_ui].primitives << with_cheese_hud
            end
        end
    end


end