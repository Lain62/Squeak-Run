class MenuScene
    attr_gtk
    attr_accessor
    def initialize
        self.args = $args
        @choices = [
            {
                name: "TUTORIAL",
                goto: :tutorial,
                current_map_id: 1
            },
            {
                name: "Level 1",
                goto: :game,
                current_map_id: 1
            },
            {
                name: "Level 2",
                goto: :game,
                current_map_id: 2
            },
            {
                name: "Level 3",
                goto: :game,
                current_map_id: 3
            },
        ]
        @current_choice = 0
    end

    def update
        if inputs.keyboard.key_down.j || inputs.keyboard.key_down.z || inputs.keyboard.key_down.space
            state.game.map_manager.current_map_id = @choices[@current_choice].current_map_id
            state.game.scene_manager.current_scene = @choices[@current_choice].goto
            
        end

        if inputs.keyboard.key_down.a || inputs.keyboard.key_down.left
            @current_choice -= 1 unless @current_choice <= 0
        end

        if inputs.keyboard.key_down.d || inputs.keyboard.key_down.right
            @current_choice += 1 unless @choices.length - 1 <= @current_choice
        end
    end

    def draw
        outputs.sprites << {
            x: 0,
            y: 0,
            w: 1280,
            h: 720,
            path: "images/Title.png"
        }
        outputs.labels << {
            x: 1280 / 2,
            y: 720 / 3 ,
            text: "A / <- #{@choices[@current_choice].name} -> / D",
            size_enum: 3,
            alignment_enum: 1,
            vertical_alignment_enum: 0
        }
        outputs.labels << {
            x: 1280 / 2,
            y: 720 / 3 - 24 ,
            text: "Press J/Z/SPACE to confirm",
            size_enum: 3,
            alignment_enum: 1,
            vertical_alignment_enum: 0
        }
    end
end