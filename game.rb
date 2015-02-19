#!/usr/bin/env ruby
require 'chingu'
# $LOAD_PATH.unshift File.join(File.expand_path(__FILE__), "..", "..", "lib")
include Gosu
include Chingu

Dir.glob('lib/**/*.rb') { |f| require_relative f }

class Game < Chingu::Window
  def initialize
    super(640, 480, false)
  end

  def setup
    retrofy
    transitional_game_state(Chingu::GameStates::FadeTo, :speed => 10)

    switch_game_state(Intro)
  end
end

class Intro < GameState
  def setup
    self.input = { :space => MainMenu }
    Text.create(:y => 320, :font => 'media/digiffiti.ttf', :size => 48, :align => :center)
  end
end

class MainMenu < GameState
  def initialize
    super
    @menu = SimpleMenu.new({
      :menu_items => [
        ['Easy', PlayState ],
        ['Hardcore', PlayState ],
        ['Bloodlust', PlayState ],
        ['Exit', lambda { exit }]
      ]
    })
  end

  def draw
    super
    @menu.draw
  end

  def update
    super
    @menu.update
  end

  def high_score
    push_game_state(GameStates::EnterName.new(:callback => method(:got_name)))
  end
  
  def got_name(name)
    puts "Got name: #{name}"
    exit
  end
end

class PlayState < GameState
  traits :viewport, :timer

  attr_reader :tiles, :player

  def initialize(options = {})
    super
    $window.caption = 'Block boy'

    self.input = {
      escape: :exit,
      s: :next_level
    }
    viewport.game_area = [0, 0, 3500, 2000]

    @level = 1

    @player = BlockBoy.create(x: 0, y: 0)
    load_level @level
  end

  def next_level
    # clean-up previous level
    Block.destroy_all
    Door.destroy_all
    Lava.destroy_all
    Background.destroy_all
    JumpPad.destroy_all
    ChangeDirectionTile.destroy_all

    # and enemies
    Walker.destroy_all
    Bouncer.destroy_all
    Flyer.destroy_all

    Fireball.destroy_all
    Coin.destroy_all
    PowerUp.destroy_all

    @level += 1
    load_level @level
  end

  def load_level(number)
    puts "loading level #{number}"
    @tiles = Tileset.new({ filename: "media/level1-#{number}.csv" }, self)
    @tiles.load

    @player.x = @tiles.spawn[0]
    @player.y = @tiles.spawn[1]
  end

  def draw
    fill(Color.new 0xffaac50e) # weird rendering bug this isn't actually the colour used!
    super
  end

  def update
    super
    viewport.center_around(@player)
  end
end

Game.new.show
