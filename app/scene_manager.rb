class SceneManager
    attr_gtk
    attr_accessor :game_scene, :menu_scene, :current_scene, :win_scene, :error_scene
    def initialize
        self.args = $args
        setup
    end

    def setup
        @current_scene = :menu
        @game_scene = GameScene.new
        @menu_scene = MenuScene.new
        @win_scene = WinScene.new
        @error_scene = ErrorScene.new
    end

    def update
        case @current_scene
        when :game then @game_scene.update
        when :menu then @menu_scene.update
        when :win then @win_scene.update
        else then @error_scene.update
        end
    end

    def draw
        case @current_scene
        when :game then @game_scene.draw
        when :menu then @menu_scene.draw
        when :win then @win_scene.draw
        else then @error_scene.draw
        end
    end
end