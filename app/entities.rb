class Rect
    attr_accessor :x, :y, :w, :h
    def initialize(x, y, w, h)
        @x = x
        @w = w
        @y = y
        @h = h
    end
end

class Entity < Rect
    attr_sprite
    attr_gtk
    attr_accessor :hitbox
    def initialize(object)
        super(object.x, object.y, object.width ,object.height)
        @args = $args
        @hitbox = true
    end
end

class PlayerSpawn < Entity
    def initialize(object)
        super(object)
        @object = object
        @path = Atlas
        @tile_w = 64
        @tile_h = 64
        @tile_x = 0 * @tile_w
        @tile_y = 1 * @tile_h
    end

    def update
        if state.game.entity_group.player == nil
            player = Player.new(@object.x, @object.y)
            state.game.entity_group.player = player
            state.game.entity_group.player.status = :default
            state.game.entity_group.player.respawn_point = 0
        end

        if state.game.entity_group.player.status == :death && state.game.entity_group.player.respawn_point == 0
            state.game.entity_group.player.cheese_status = :ungrabbed
            state.game.entity_group.player.x = @object.x
            state.game.entity_group.player.y = @object.y
            state.game.entity_group.player.status = :default
        end
        if @hitbox == true
            if state.game.entity_group.player.cheese_status == :grabbed && Geometry.intersect_rect?(state.game.entity_group.player, self)
                state.game.entity_group.player.win_status = :win
            end
        end
    end
end

class PlayerFlag < Entity
    def initialize(object, flag_number)
        super(object)
        @flag_number = flag_number
        @object = object
        @status = "untouched"
        @path = Atlas
        @tile_w = 64
        @tile_h = 64
        @tile_x = 2 * @tile_w
        @tile_y = 0 * @tile_h
        @resetted = false
    end

    def update
        return if state.game.entity_group.player == nil

        if @status == "touched"
            @tile_x = 2 * @tile_w
            @tile_y = 1 * @tile_h
        end
        if @status == "untouched"
            @tile_x = 2 * @tile_w
            @tile_y = 0 * @tile_h
        end
        if @hitbox == true 
            if Geometry.intersect_rect?(state.game.entity_group.player, self) && @status == "untouched"
                state.game.entity_group.player.respawn_point = @flag_number
                @status = "touched"
            end

            if state.game.entity_group.player.cheese_status == :grabbed && @resetted == false
                @status = "untouched"
                @resetted = true
            end

            if state.game.entity_group.player.status == :death && state.game.entity_group.player.respawn_point == @flag_number
                state.game.entity_group.player.cheese_status = :ungrabbed
                state.game.entity_group.player.x = @object.x
                state.game.entity_group.player.y = @object.y
                state.game.entity_group.player.status = :default

            end
        end
    end
end


class CatTimer
    attr_accessor :timer
    attr_gtk
    def initialize
        self.args = $args
        @timer_max = 60 * 10
        @timer = @timer_max
        @width_multiplier = 20
    end

    def timer_in_second
        @timer / 60
    end

    def meter_pos
        [1280 / 2 - @timer_max / 60 * @width_multiplier / 2, 680]
    end

    def meter
        {
            x: meter_pos.x,
            y: meter_pos.y,
            w: timer_in_second * @width_multiplier,
            h: 20,
            path: Atlas,
            tile_h: 64,
            tile_w: 64,
            tile_x: 2 * 64,
            tile_y: 2 * 64
        }
    end

    def meter_background
        {
            x: meter_pos.x,
            y: meter_pos.y,
            w: @timer_max / 60 * @width_multiplier,
            h: 20,
            path: Atlas,
            tile_h: 64,
            tile_w: 64,
            tile_x: 3 * 64,
            tile_y: 2 * 64
        }
    end

    def update

        if @timer <= 0
            @timer = @timer_max
            state.game.entity_group.player.cheese_status = :ungrabbed
            state.game.entity_group.player.status = :death
        end

        if state.game.entity_group.player.safe_status == :safe
            @timer += 4 if @timer < @timer_max
        end

        if @timer > @timer_max
            @timer = @timer_max
        end

        @timer -= 1 if @timer > 0 && state.game.entity_group.player.safe_status == :unsafe
    end
end

class Cheese < Entity
    def initialize(object)
        super(object)
        @object = object
        @path = Atlas
        @tile_w = 64
        @tile_h = 64
        @tile_x = 1 * @tile_w
        @tile_y = 1 * @tile_h
    end

    def update
        if @hitbox == true
            if Geometry.intersect_rect?(state.game.entity_group.player, self)
                @w = 0
                @h = 0
                state.game.entity_group.player.cheese_status = :grabbed
                @hitbox = false
            end
        end
        if state.game.entity_group.player.cheese_status == :ungrabbed
            @w = 64
            @h = 64
            @hitbox = true
        end
    end

end