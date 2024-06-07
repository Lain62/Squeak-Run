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
        outputs.sprites << {
            x: 0,
            y: 0,
            w: 1280,
            h: 720,
            path: "images/win.png"
        }
    end
end