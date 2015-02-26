#!/usr/bin/env ruby
require 'chingu'
include Gosu
include Chingu

require_relative 'lib/block_boy'
require_relative 'lib/block'
require_relative 'lib/fireball'
require_relative 'lib/items'
require_relative 'lib/menu'
require_relative 'lib/Music'
require_relative 'lib/notify'
require_relative 'lib/tileset'
require_relative 'lib/walker'

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
    self.input = { space: MainMenu }
    @text = Text.create(y: 200, x: $window.width / 2, font: 'media/digiffiti.ttf', size: 48, text: 'Handmadebymogwai')
    @text.x -= @text.width / 2.2

    after(1000) { switch_game_state MainMenu }
  end
end

class TextHeavyState < GameState
  def double_text(string, y, size=28)
    centered_text string, y, Color.new(0xff0e4612), size
    centered_text string, (y + 4), Color.new(0xff3c733f), size
  end

  def centered_text(string, y, color, size = 56)
    text = Text.create(
      y: y,
      x: $window.width / 2,
      font: 'media/bubble.ttf',
      size: size,
      color: color,
      text: string)
    text.x -= text.image.width / 2
  end
end

class MainMenu < TextHeavyState
  def initialize
    super
    Music.play
    double_text 'SUPER', 50, 80
    double_text 'BlockBoy', 120, 56

    double_text '---------', 180

    @menu = CustomMenu.new(
      menu_items: [
        ['Easy', lambda {
          state = Controls.new(:mode => :easy)
          switch_game_state state
        }],
        ['Hardcore', lambda { 
          state = Controls.new(:mode => :hardcore)
          switch_game_state state
        }],
        ['Bloodlust', lambda { 
          state = Controls.new(:mode => :bloodlust)
          switch_game_state state
        }],
        ['Exit', lambda { exit }]
      ],
      font: 'media/bubble.ttf',
      size: 28,
      spacing: 25,
      selected_color: Color.new(0xff0e4612),
      unselected_color: Color.new(0xff3c733f),
      y: 200
    )

    double_text '---------', 395
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

class Controls < TextHeavyState
  trait :timer
  def initialize(options = {})
    super
    @mode = options[:mode]
  end

  def setup
    self.input = { space: :start }
    after(5000) { start }
    
    double_text 'Controls', 120, 56

    double_text '---------', 180    
    double_text 'Arrow keys mode', 225
    double_text 'Hold Z to run', 250
    double_text 'Press X to fireball', 275 
    double_text 'Press R to reset', 300

    if @mode == :bloodlust
      double_text 'To complete levels', 325
      double_text 'You must kill all enemies', 350
      double_text '---------', 385
    else
      double_text 'Get to the door to', 325
      double_text 'Complete the level', 350
      double_text '---------', 385
    end
  end

  def start
    state = PlayState.new(:mode => @mode)
    switch_game_state state
  end

  def draw
    super
    fill(Color.new 0xffaac50e)
  end
end

class Complete < TextHeavyState
  trait :timer
  def setup
    self.input = { space: :start }
    after(2000) { start }
    
    double_text 'Well done', 120, 56

    double_text '---------', 180    
    double_text 'But the princess', 225
    double_text 'is in anonther', 250
    double_text 'castle....', 275 
    double_text 'Game over!', 300
    double_text '---------', 325
  end

  def start
    state = MainMenu.new
    switch_game_state state
  end

  def draw
    super
    fill(Color.new 0xffaac50e)
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
    set_mode options[:mode]
    load_level @level
  end

  def set_mode(mode)
    @player.set_mode mode
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
    if number == 13
      state = Complete.new
      switch_game_state state
      return
    end
    puts "loading level #{number}"
    @tiles = Tileset.new({ filename: "media/level1-#{number}.csv" }, self)
    @tiles.load

    @player.x = @tiles.spawn[0]
    @player.y = @tiles.spawn[1]
    @player.set_spawn @player.x, @player.y
  end

  def notify(text)
    @notify.destroy if @notify
    x = viewport.game_area.x + $window.width / 2
    y = viewport.game_area.y + $window.height / 2 
    puts "#{x} #{y}"
    @notify = Notify.new text, x, y
  end

  def draw
    fill(Color.new 0xffaac50e) # weird rendering bug this isn't actually the colour used!
    super
  end

  def update
    super
    viewport.center_around(@player)

    if @notify
      @notify.update
      if @notify.dead?
        @notify.destroy
        @notify = nil
      end
    end
  end
end

Game.new.show
