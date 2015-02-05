class Enemy < GameObject
  def check_collides_with_block
    tiles = game_state.tiles.tiles_around_object(self)
    each_collision(tiles) do | _me, tile |
      if tile.instance_of? Block
        self.y = tile.bb.top - 1
      end
    end
  end

  def self.all_enemies
    out = []
    out.concat Walker.all
    out.concat Bouncer.all
    out.concat Flyer.all
  end
end

class Flyer < Enemy
  trait :bounding_box, debug: true
  traits :collision_detection, :velocity, :timer

  def setup
    @animations = Chingu::Animation.new(file: 'enemies_16x16.png')
    @animations.frame_names = { fly: 8..10 }

    @animation = @animations[:fly]

    set_direction @options[:direction]

    self.zorder = 300
    self.max_velocity = 10
    self.rotation_center = :bottom_center

    @origin = x

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
    return unless game_state.viewport.inside? self

    if x % @origin >= 70
      if @direction == :left
        set_direction :right
      else
        set_direction :left
      end
    end
  end
end

class Walker < Enemy
  trait :bounding_box, debug: true
  traits :collision_detection, :velocity, :timer

  def setup
    @animations = Chingu::Animation.new(file: 'enemies_16x16.png')
    @animations.frame_names = { walk: 0..2 }

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
    return unless game_state.viewport.inside? self

    check_collides_with_block

    next_tile = game_state.tiles.tile_at_object(self, @direction)

    if next_tile && (next_tile.x + x == width / 2) || next_tile.instance_of?(Block)
      if @direction == :left
        set_direction :right
      else
        set_direction :left
      end
    end
  end
end

class Bouncer < Enemy
  trait :bounding_box, debug: true
  traits :collision_detection, :velocity, :timer

  def setup
    @animations = Chingu::Animation.new(file: 'enemies_16x16.png')
    @animations.frame_names = { bouncer: 4..7 }
    @animation = @animations[:bouncer]

    self.zorder = 300
    self.max_velocity = 10
    self.acceleration_y = 0.5 # gravity!
    self.rotation_center = :bottom_center

    update
    cache_bounding_box

    every(500) do
      self.velocity_y = -7
    end
  end

  def update
    @image = @animation.next
    return unless game_state.viewport.inside? self

    check_collides_with_block
  end
end
