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

    if next_tile && next_tile.x == 0 || next_tile.instance_of?(Block)
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