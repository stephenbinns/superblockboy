#!/usr/bin/env ruby
require 'chingu'
#$LOAD_PATH.unshift File.join(File.expand_path(__FILE__), "..", "..", "lib")
include Gosu
include Chingu

Dir.glob('lib/**/*.rb') { |f| require_relative f }

class Game < Chingu::Window
  def initialize
    super(640,480, false)
  end
  
  def setup
    retrofy
    switch_game_state(PlayState)
  end    
end

class PlayState < GameState
  traits :viewport, :timer

  attr_reader :tiles

  def initialize(options = {})
    super
    $window.caption = "Block boy"

    self.input = { :escape => :exit }
    self.viewport.game_area = [0, 0, 3500, 2000]

    load_level "media/level1.csv"
    @player = BlockBoy.create(:x => 100, :y => 100)
  end

  def load_level(filename)
    @tiles = Tileset.new({ :filename => filename })
    @tiles.load

    Walker.create(:x => 10 * 16, :y => 3 * 16, :direction => :left)
    Walker.create(:x => 15 * 16, :y => 3 * 16, :direction => :right)
    Bouncer.create(:x => 17 * 16, :y => 3 * 16)
  end

  def draw
    super
  end

  def update
    super
    self.viewport.center_around(@player)
  end
end

Game.new.show