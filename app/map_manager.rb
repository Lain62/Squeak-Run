class MapManager
    attr_gtk
    attr_accessor :current_map_id
    attr_reader :maps
    def initialize
        self.args = $args
        @maps = [
            Map.new("data/maps/untitled-test.tmx"),
            Map.new("data/maps/Level_1.tmx"),
            Map.new("data/maps/Level_2.tmx"),
            Map.new("data/maps/Level_3.tmx"),
            Map.new("data/maps/Level_1.tmx"),
            Map.new("data/maps/Level_1.tmx"),
            Map.new("data/maps/Level_1.tmx")
        ]
        @current_map_id = 1
    end

    def current_map
        @maps[@current_map_id].data
    end

    def load_current_map
        @maps[@current_map_id].load
        
        # puts @maps[@current_map_id].player
    end

    def unload_current_map
        @maps[@current_map_id].unload
    end

    def change_current_map(map_id)
        @current_map_id = map_id
    end

end