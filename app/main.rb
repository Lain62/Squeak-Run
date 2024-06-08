require "app/require.rb"
module RatGame
  class Game
    attr_accessor :scenes
    def initialize
      Globals::State.ogmo = Drogmo::Project.new("content/squeak_run.ogmo")
      @scenes = Scenes.new()
    end

    def update
      @scenes.update
    end

    def draw
      @scenes.draw
    end
  end
end

def tick args
  args.state.game ||= RatGame::Game.new()
  args.state.game.update
  args.state.game.draw
end
