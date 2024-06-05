
class Map
    attr_gtk
    attr_reader :data
    attr_accessor :player
    def initialize(path)
        self.args = $args
        @path = path
        @data = Tiled::Map.new(@path)
        @load_status = false
    end

    def unload
        @data = Tiled::Map.new(@path)
        @load_status = false
    end

    def load
        if @load_status == false
            state.game.draw_group.reset
            state.game.entity_group.reset
            @data.load
            load_size
            load_sprites
            load_entities
            @load_status = true
        end
    end

    def load_size
        state.game.draw_group.width = @data.width * @data.tilewidth
        state.game.draw_group.height = @data.height * @data.tileheight
    end

    def load_sprites
        load_sprite_at_layer("Tile")
    end

    def load_entities
        load_entity_at_layer('Object') 
        load_entity_at_layer('Collision') 
        load_entity_at_layer('Safe') 
        load_cattimer
    end

    def load_cattimer
        state.game.entity_group.cat_timer = CatTimer.new
    end

    def load_sprite_at_layer(layer)
        if @data.layers[layer].respond_to? (:sprites)
            state.game.draw_group.tile_sprites << @data.layers[layer].sprites
        end
    end


    def load_entity_at_layer(layer)
        if @data.layers[layer].respond_to? (:objects)
            # puts @data.layers[layer].objects
            @data.layers[layer].objects.each do |object|
                case object.object_type
                when :tile
                    case object.tile.type
                    when "Player_Spawn"
                        player_spawn = PlayerSpawn.new(object)
                        state.game.entity_group.player_spawn = player_spawn
                    when "Player_Flag"
                        player_flag = PlayerFlag.new(object, state.game.entity_group.player_flag.length + 1)
                        state.game.entity_group.player_flag << player_flag
                    when "Cheese"
                        cheese = Cheese.new(object)
                        state.game.entity_group.cheese = cheese
                    end
                when :rectangle
                    case layer
                    when "Collision"
                        state.game.entity_group.collisions << Rect.new(object.x, object.y, object.width, object.height)
                    when "Safe"
                        state.game.entity_group.safe_zone << Rect.new(object.x, object.y, object.width, object.height)
                    when "Hazard"
                        state.game.entity_group.hazards << Rect.new(object.x, object.y, object.width, object.height)
                    end
                end
            end
        end
    end
end