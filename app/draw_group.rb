class DrawGroup
    attr_accessor :tile_sprites, :entity_sprites, :width, :height
    attr_gtk
    def initialize
        self.args = $args
        @width = 1280
        @height = 720
        @tile_sprites = []
    end

    def player_sprite
        state.game.entity_group.player
    end

    def entity_sprites
        state.game.entity_group.entities_with_sprites
    end

    def sprites 
        [@tile_sprites, entity_sprites, player_sprite]
    end

    def ui
        [ 
            state.game.entity_group.ui_sprites
        ]
    end

    def reset
        @tile_sprites = []
        @entity_sprites = []
    end

    def draw(offset = [0, 0])
        raise "ERROR DRAWGROUP OFFSET DOESNT RESPOND TO X" if !offset.respond_to?(:x)
        raise "ERROR DRAWGROUP OFFSET DOESNT RESPOND TO Y" if !offset.respond_to?(:y)

        outputs[:scene].transient!
        outputs[:scene].w = @width
        outputs[:scene].h = @height
        outputs[:scene].sprites << sprites
        outputs[:ui].transient!
        outputs[:ui].w = 1280
        outputs[:ui].h = 720
        outputs[:ui].sprites << ui
        outputs.sprites << {
            x: -offset.x + 1280 / 2,
            y: -offset.y + 720 / 2,
            w: @width,
            h: @height,
            path: :scene
        }
        outputs.sprites << {
            x: 0,
            y: 0,
            w: 1280,
            h: 720,
            path: :ui
        }
    end
end