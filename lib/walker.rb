class Enemy < GameObject
  def check_collides_with_block
    tiles = self.game_state.tiles.tiles_around_object(self)
    self.each_collision(tiles) do | me, tile |
      if tile.instance_of? Block
        self.y = tile.bb.top-1
      end
    end
  end
end

class Walker < Enemy
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
    
    check_collides_with_block

    next_tile = self.game_state.tiles.tile_at_object(self, @direction)

    if next_tile && (next_tile.x + self.x == self.width / 2 ) || next_tile.instance_of?(Block)
      if @direction == :left
        set_direction :right
      else
        set_direction :left
      end
    end

  end
end

class Bouncer < Enemy
  trait :bounding_box, :debug => true
  traits :collision_detection, :velocity, :timer

  def setup
    @animations = Chingu::Animation.new(:file => "enemies_16x16.png")
    @animations.frame_names = { :bouncer => 4..7 }
    @animation = @animations[:bouncer]
    
    self.zorder = 300
    self.max_velocity = 10
    self.acceleration_y = 0.5 # gravity!
    self.rotation_center = :bottom_center

    update
    cache_bounding_box

    every(500) {
      self.velocity_y = -7
    }
  end

  def update
    @image = @animation.next
    return unless self.game_state.viewport.inside? self

    check_collides_with_block
  end
end
