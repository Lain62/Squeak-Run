class GameScene
    attr_gtk
    def initialize
        self.args = $args
    end

    def update
        state.game.map_manager.load_current_map
        state.game.entity_group.update
        if state.game.entity_group.player.win_status == :win
            state.game.map_manager.unload_current_map
            state.game.map_manager.current_map_id += 1 unless state.game.map_manager.maps.length - 1 <= state.game.map_manager.current_map_id
            state.game.scene_manager.current_scene = :win
        end
    end

    def draw
        outputs.sprites << {
            x: 0,
            y: 0,
            w: 1280,
            h: 720,
            path: "images/byfreepik.jpg"
        }
        player_offset = [0, 0]
        if state.game.entity_group.player != nil
          player_offset = [state.game.entity_group.player.x + state.game.entity_group.player.w / 2, state.game.entity_group.player.y + state.game.entity_group.player.h / 2]
        end
        state.game.draw_group.draw(player_offset)
    end
end