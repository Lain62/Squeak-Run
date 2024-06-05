class MenuScene
    attr_gtk
    attr_accessor
    def initialize
        self.args = $args
        
    end

    def update
        if inputs.keyboard.key_down.j || inputs.keyboard.key_down.z || inputs.keyboard.key_down.space
            state.game.scene_manager.current_scene = :game
        end

        if inputs.keyboard.key_down.a
            state.game.map_manager.current_map_id -= 1 unless state.game.map_manager.current_map_id <= 1
        end

        if inputs.keyboard.key_down.d
            state.game.map_manager.current_map_id += 1 unless state.game.map_manager.maps.length - 1 <= state.game.map_manager.current_map_id
        end
    end

    def draw
        outputs.labels << {
            x: 1280 / 2,
            y: 720 / 3 * 2,
            text: "Untitled Mouse Game",
            size_enum: 24,
            alignment_enum: 1,
            vertical_alignment_enum: 0
        }
        outputs.labels << {
            x: 1280 / 2,
            y: 720 / 3 * 2 - 24 ,
            text: "WASD / ARROW KEYS TO MOVE, J/Z/SPACE TO JUMP",
            size_enum: 3,
            alignment_enum: 1,
            vertical_alignment_enum: 0
        }
        outputs.labels << {
            x: 1280 / 2,
            y: 720 / 3 ,
            text: "A <- LEVEL #{state.game.map_manager.current_map_id} -> D",
            size_enum: 3,
            alignment_enum: 1,
            vertical_alignment_enum: 0
        }
        outputs.labels << {
            x: 1280 / 2,
            y: 720 / 3 - 24 ,
            text: "Press J/Z/SPACE to Play the level",
            size_enum: 3,
            alignment_enum: 1,
            vertical_alignment_enum: 0
        }
    end
end