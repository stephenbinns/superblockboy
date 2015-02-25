class Enemy < GameObject
  trait :effect
  def check_collides_with_block
    tiles = game_state.tiles.tiles_around_object(self)
    each_collision(tiles) do | _me, tile |
      self.y = tile.bb.top - 1
    end
  end

  def self.all_enemies
    out = []
    out.concat Walker.all
    out.concat Bouncer.all
    out.concat Flyer.all
  end

  def visible?
    game_state.viewport.inside? self 
  end

  def draw
    if visible?
      super
    end
  end

  def update
    if visible?
      super
    end
  end

  def die
    self.collidable = false # Stops further collisions in each_collsiion() etc.
    self.rotation_rate = 5
    self.scale_rate = 0.005
    self.fade_rate = -1
    after(2000) { destroy }
  end

  def inside?
    x, y = game_state.player.x, game_state.player.y

    x_ok = x >= @x - $window.width &&  @x <= x + $window.width
    y_ok = @y >= y - $window.height && @y <= y + $window.height

    x_ok && y_ok
  end
end

class Flyer < Enemy
  trait :bounding_box, debug: false
  traits :collision_detection, :velocity, :timer

  def setup
    @animations = Chingu::Animation.new(file: 'media/enemies_16x16.png')
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

  def die
    self.velocity_y = 0.5
    super
  end

  def update
    @image = @animation.next

    unless inside?
      self.velocity_x = 0
      self.velocity_y = 0
      return
    else
      set_direction :left if velocity_x == 0
    end

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
  trait :bounding_box, debug: false
  traits :collision_detection, :velocity, :timer

  def setup
    @animations = Chingu::Animation.new(file: 'media/enemies_16x16.png')
    @animations.frame_names = { walk: 0..2 }

    @animation = @animations[:walk]

    set_direction @options[:direction]

    self.zorder = 300
    self.max_velocity = 10
    self.acceleration_y = 0.5 # gravity!
    self.rotation_center = :bottom_center

    # update
    @image = @animation.next
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
    unless inside?
      self.velocity_y = 0
      self.velocity_x = 0
      self.acceleration_y = 0
      return
    else
      self.acceleration_y = 0.5
      set_direction :left if velocity_x == 0
    end

    check_collides_with_block

    next_tile = game_state.tiles.tile_at_object(self, @direction)
    if next_tile.instance_of?(Block) || next_tile.instance_of?(ChangeDirectionTile)
      if @direction == :left
        set_direction :right
      else
        set_direction :left
      end
    end
  end
end

class Bouncer < Enemy
  trait :bounding_box, debug: false
  traits :collision_detection, :velocity, :timer

  def setup
    @animations = Chingu::Animation.new(file: 'media/enemies_16x16.png')
    @animations.frame_names = { bouncer: 4..7 }
    @animation = @animations[:bouncer]

    self.zorder = 300
    self.max_velocity = 10
    self.acceleration_y = 0.5 # gravity!
    self.rotation_center = :bottom_center

    # update
    @image = @animation.next
    cache_bounding_box

    every(700) do
      self.velocity_y = -7
    end
  end

  def update
    @image = @animation.next
    check_collides_with_block
  end
end
