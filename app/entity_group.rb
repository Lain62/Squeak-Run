class EntityGroup
    attr_gtk
    attr_accessor :collisions, :player, :player_spawn, :player_flag, :cat_timer, :safe_zone, :cheese, :hazards
    def initialize
        self.args = $args
        @player_spawn = nil
        @player_flag = []
        @player = nil
        @collisions = []
        @safe_zone = []
        @cat_timer = nil
        @cheese = nil
        @hazards = []
    end

    def entities_collection
        [
            @player_flag
        ]
    end

    def entities
        [
            @player_spawn,
            @cat_timer,
            @cheese
        ]
    end

    def entities_with_sprites
        [
            @player_flag,
            @player_spawn,
            @cheese
        ]
    end

    def ui_sprites
        if @cat_timer != nil
            cat_timer_ui = [
                @cat_timer.meter_background,
                @cat_timer.meter
            ]
        end
        [
            cat_timer_ui
        ]
    end

    def reset
        @player_spawn = nil
        @player_flag = []
        @collisions = []
        @player = nil
        @timer = nil
    end

    def reset_player
        @player = nil
    end

    def update
        if @player != nil
            @player.update
        end

        entities_collection.each do |entity_collection|
                entity_collection.each do | entity |
                    if entity.respond_to? (:update)
                        entity.update
                    end
            end
        end

        entities.each do |entity|
            if entity.respond_to? (:update)
                entity.update
            end
        end
    end
end