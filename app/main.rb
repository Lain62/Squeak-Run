Atlas = "sprites/tiles/atlas.png"
require 'lib/tiled/tiled.rb'
require 'app/entities.rb'
require 'app/draw_group.rb'
require 'app/entity_group.rb'
require 'app/map_manager.rb'
require 'app/game_scene.rb'
require 'app/menu_scene.rb'
require 'app/win_scene.rb'
require 'app/error_scene.rb'
require 'app/tutorial_scene.rb'
require 'app/about_scene.rb'
require 'app/audio_manager.rb'
require 'app/scene_manager.rb'
require 'app/map.rb'
require 'app/player.rb'

class RatGame
  attr_gtk
  attr_accessor :map_manager, :draw_group, :entity_group, :scene_manager
  def initialize
    self.args = $args
    setup
  end

  def setup
    @map_manager = MapManager.new
    @draw_group = DrawGroup.new
    @entity_group = EntityGroup.new
    @scene_manager = SceneManager.new
  end

  def update
    @scene_manager.update
  end

  def draw
    @scene_manager.draw
  end

  def debug
  end
end

def tick args
  args.state.game ||= RatGame.new
  args.state.game.update
  args.state.game.debug
  args.state.game.draw
end
