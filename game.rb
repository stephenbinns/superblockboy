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
    switch_game_state(Intro)
  end
end

class Intro < GameState
  trait :timer
  def setup
    self.input = { :space => MainMenu }
    @text = Text.create(:y => 200, :x => $window.width/2, :font => 'media/digiffiti.ttf', :size => 48, :text => 'Handmadebymogwai')
    @text.x -= @text.width / 2.2 

    after(1000) { switch_game_state MainMenu }
  end
end

class MainMenu < GameState
  def initialize
    super

    centered_text 'SUPER', 50, Color.new(0xff306230), 80
    centered_text 'SUPER', 54, Color.new(0xff0F380F), 80

    centered_text 'BlockBoy', 120, Color.new(0xff306230)
    centered_text 'BlockBoy', 124, Color.new(0xff0F380F)

    centered_text '---------', 180, Color.new(0xff306230), 28
    centered_text '---------', 184, Color.new(0xff0F380F), 28

    @menu = CustomMenu.new({
      :menu_items => [
        ['Easy', PlayState ],
        ['Hardcore', PlayState ],
        ['Bloodlust', PlayState ],
        ['Exit', lambda { exit }]
      ],
      :font => 'media/bubble.ttf',
      :size => 28,
      :spacing => 25,
      :selected_color => Color.new(0xff306230),
      :unselected_color => Color.new(0xff0F380F),
      :y => 200
    })

    centered_text '---------', 395, Color.new(0xff306230), 28
    centered_text '---------', 399, Color.new(0xff0F380F), 28
  end

  def centered_text(string, y, color, size=56)
    text = Text.create(
      :y => y,
      :x => $window.width/2,
      :font => 'media/bubble.ttf',
      :size => size,
      :color => color,
      :text => string)
    text.x -= text.image.width / 2 
  end

  def draw
    super
    fill(Color.new 0xffaac50e) # weird rendering bug this isn't actually the colour used!
    @menu.draw
  end

  def update
    super
    @menu.update
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
