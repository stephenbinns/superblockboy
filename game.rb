#!/usr/bin/env ruby
require 'chingu'
$LOAD_PATH.unshift File.join(File.expand_path(__FILE__), "..", "..", "lib")
include Gosu
include Chingu

#
# Press 'E' when demo is running to edit the playfield!
# 
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

    @player = BlockBoy.create(:x => 100, :y => 100)

    load_level "media/level1.csv"
  end

  def load_level(filename)
    @tiles = Tileset.new({ :filename => filename })
    @tiles.load

    Walker.create(:x => 10 * 16, :y => 3 * 16, :direction => :left)
    Walker.create(:x => 15 * 16, :y => 3 * 16, :direction => :right)
  end

  def draw
    super
  end

  def update
    super
    self.viewport.center_around(@player)
  end
end

class Tileset
  def initialize(options = {})
    @block_height = options[:block_height] || 16
    @block_width = options[:block_width] || 16
    filename = options[:filename]
    tileset_name = options[:tileset_name] || "tiles"

    @tileset = Image.load_tiles($window, "media/#{tileset_name}.png", @block_height, @block_width, true)
    @lines = File.readlines(filename).map { |line| line.chomp }

    @height = @lines.size
    @width = @lines[0].split(',').length
  end

  def load
    @tiles = Array.new(@width) do |y|
      blocks = @lines[y].split ','
      Array.new(@height) do |x|
        block = blocks[x].to_i
        b_x, b_y  = x * @block_width, y * @block_height

        if [8,9,10,11,16,17,18,19].any? { |b| b == block }
          Background.create(:x => b_x, :y => b_y, :image => @tileset[block])
        elsif [5,6,12].any? { |b| b == block }
          Lava.create(:x => b_x, :y => b_y, :image => @tileset[block]) 
        else
          Block.create(:x => b_x, :y => b_y, :image => @tileset[block])
        end
      end
    end
  end

  def tile_at_object(object, direction = :center)
    if object.respond_to? :bb
      ox, oy = object.bb.midbottom[0], object.bb.midbottom[1]

      if direction == :left
        ox = object.bb.midleft[0] 
      elsif direction == :right
        ox = object.bb.midright[0]
      elsif direction == :below
        oy += @block_height + 8
      end
          
      tile_at(ox, oy)
    else
      raise 'Object does not respond to bb'
    end
  end

  def tile_at(x, y)
    x -= x % @block_width
    y -= y % @block_height

    @tiles[y / @block_height][x / @block_width]
  end
end

class BlockBoy < GameObject
  trait :bounding_box, :scale => 0.50, :debug => false
  traits :timer, :collision_detection , :velocity
  
  def setup
    self.input = {  
      [:holding_left, :holding_a] => :holding_left, 
      [:holding_right, :holding_d] => :holding_right,
      [:up, :w] => :jump,
      [:x] => :fireball
    }

    @animations = Chingu::Animation.new(:file => "player_16x16.png")
    @animations.frame_names = { :none => 0..0, :left => 4..6, :right => 0..3}
    
    @animation = @animations[:none] 

    @speed = 3
    @jumping = false
    self.zorder = 300
    self.acceleration_y = 0.5 # gravity!
    self.max_velocity = 10
    self.rotation_center = :bottom_center
    @direction = :right
    
    update
    cache_bounding_box
  end

  def holding_left
    move(-@speed, 0)
    self.factor_x = -1
    @direction = :left
    @animation = @animations[:right]
  end

  def holding_right
    move(@speed, 0)
    self.factor_x = 1
    @direction = :right
    @animation = @animations[:right]
  end

  def fireball
    Fireball.create(:x => self.x, :y => self.y - 8, :direction => @direction)
  end

  def jump
    return if @jumping
    @jumping = true
    self.velocity_y = -10
  end
  
  def move(x,y)
    self.x += x
    self.each_collision(Block) do |me, stone_wall|
      self.x = previous_x
      break
    end
    
    self.y += y
  end

  def update 
    @image = @animation.next

    self.each_collision(Block.inside_viewport) do |me, block|
      if self.velocity_y < 0  # Hitting the ceiling
        me.y = block.bb.bottom + me.image.height * self.factor_y
        self.velocity_y = 0
      else  # Land on ground
        @jumping = false        
        me.y = block.bb.top-1
      end

      break # perf!
    end

    self.each_collision(Lava) do |me, lava|
      self.x = 100
      self.y = 100
      break
    end
    @animation = @animations[:none] unless moved?
  end
end


class Block < GameObject
  trait :bounding_box, :debug => false
  trait :collision_detection

  def self.inside_viewport
    all.select { |block| block.game_state.viewport.inside?(block) }
  end

  def setup
    cache_bounding_box
  end
end

class Background < GameObject
end

class Lava < GameObject
  trait :bounding_box, :debug => false
  trait :collision_detection

  def setup
    cache_bounding_box
  end
end



class Walker < GameObject
  trait :bounding_box, :debug => true
  traits :collision_detection, :velocity, :timer

  def setup
    @animations = Chingu::Animation.new(:file => "enemies_16x16.png")
    @animations.frame_names = { :walk => 0..2 }
    
    @animation = @animations[:walk] 


    set_direction @options[:direction]

    self.zorder = 300
    self.max_velocity = 10
    self.acceleration_y = 0.5 # gravity!
    self.rotation_center = :bottom_center

    update
    cache_bounding_box
  end

  def set_direction(direction)
    if direction == :left
      self.factor_x = -1
      self.velocity_x = -2
    else
      self.factor_x = 1
      self.velocity_x = 2
    end
    @direction = direction
  end

  def update 
    @image = @animation.next
    return unless self.game_state.viewport.inside? self

    tile = self.game_state.tiles.tile_at_object(self)
    if tile.instance_of? Block
      self.y = tile.bb.top-1
    end

    next_tile = self.game_state.tiles.tile_at_object(self, @direction)

    if next_tile.x == 0 || next_tile.instance_of?(Block)
      if @direction == :left
        set_direction :right
      else
        set_direction :left
      end
    end

  end
end
class Bouncer < Walker
  def setup
    super
  end

  def update
    super

    every(100) {
      tile = self.game_state.tiles.tile_at_object(self, :below)
      if tile != @last_tile
        puts tile
      end
      @last_tile = tile
      if tile.instance_of? Block
        self.velocity_y = -1
        puts 'boing'
      end
    }
  end
end

class Fireball < GameObject
  trait :bounding_box, :debug => true, :scale => 1.0 # solves bounding issues but is perhaps TOO big
  traits :collision_detection, :velocity, :timer

  def setup
    @animations = Chingu::Animation.new(:file => "items_16x16.png")
    @animations.frame_names = { :fire => 8..11 }
    
    @animation = @animations[:fire] 

    if @options[:direction] == :left
      self.factor_x = -1
      self.velocity_x = -5
    else
      self.velocity_x = 5
    end

    self.zorder = 300
    self.acceleration_y = 0.5 # gravity!
    self.max_velocity = 10

    update
    cache_bounding_box

    after(2000) { destroy }
  end

  def update 
    @image = @animation.next

    # todo sometime the bounce doesn't work correctly
    # e.g when standing on a high block
    # possibly due to speed being too high?
    self.each_collision(Block.inside_viewport) do |me, block|
      if self.y > block.bb.top
        self.velocity_x = -5
      else
        self.velocity_y = -5
      end

      break
    end
  end
end

Game.new.show