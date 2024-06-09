require "app/require.rb"
module RatGame
  class Game
    attr_accessor :scenes
    def initialize
      Globals.state.project.ogmo = Drogmo::Project.new("content/squeak_run.ogmo")
      Globals.state.scene.manager = SceneManager.new()
    end

    def update
      Globals.state.scene.manager.update
    end

    def draw
      Globals.state.scene.manager.draw
    end
  end
end

def tick args
  args.state.game ||= RatGame::Game.new()
  args.state.game.update
  args.state.game.draw
end
