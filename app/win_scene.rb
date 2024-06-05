class WinScene
    attr_gtk
    def initialize
        @args = $args
    end

    def update
        if inputs.keyboard.key_down.j || inputs.keyboard.key_down.z || inputs.keyboard.key_down.space
            state.game.scene_manager.current_scene = :menu
        end
    end

    def draw
        outputs.labels << {
            x: 1280 / 2,
            y: 720 / 3 * 2,
            text: "YOU WIN!",
            size_enum: 24,
            alignment_enum: 1,
            vertical_alignment_enum: 0
        }
        outputs.labels << {
            x: 1280 / 2,
            y: 720 / 3 - 24 ,
            text: "Press J/Z/SPACE to go back to menu",
            size_enum: 3,
            alignment_enum: 1,
            vertical_alignment_enum: 0
        }
    end
end