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
        @tutorial_scene = TutorialScene.new
        @about_scene = AboutScene.new
        @error_scene = ErrorScene.new
        @audio_manager = AudioManager.new
    end

    def update
        case @current_scene
        when :game then @game_scene.update
        when :menu then @menu_scene.update
        when :win then @win_scene.update
        when :about then @about_scene.update
        when :tutorial then @tutorial_scene.update
        else @error_scene.update
        end

        @audio_manager.update
    end

    def draw
        case @current_scene
        when :game then @game_scene.draw
        when :menu then @menu_scene.draw
        when :win then @win_scene.draw
        when :about then @about_scene.draw
        when :tutorial then @tutorial_scene.draw
        else @error_scene.draw
        end
    end
end