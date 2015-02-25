class BlockBoy < GameObject
  trait :bounding_box, scale: 0.80, debug: false
  traits :timer, :collision_detection, :velocity, :effect

  def setup
    self.input = {
      [:holding_left, :holding_a] => :holding_left,
      [:holding_right, :holding_d] => :holding_right,
      [:up, :w] => :jump,
      [:x] => :fireball,
      [:holding_z] => :run,
      [:r] => :reset
    }

    @animations = Chingu::Animation.new(file: 'media/player_16x16.png')
    @animations.frame_names = { none: 0..0, left: 4..6, right: 0..3 }

    @animation = @animations[:none]

    @speed = 3
    @jumping = false
    self.zorder = 300
    self.acceleration_y = 0.5 # gravity!
    self.max_velocity = 20
    self.rotation_center = :bottom_center
    @direction = :right

    update
    cache_bounding_box
  end

  def set_mode(mode)
    if mode == :hardcore
      @hardcore = true
    elsif mode == :bloodlust
      @bloodlust = true
    end
  end

  def holding_left
    move(-@speed, 0)
    self.factor_x = -1
    @direction = :left
    @animation = @animations[:right]
    @speed = 3
  end

  def holding_right
    move(@speed, 0)
    self.factor_x = 1
    @direction = :right
    @animation = @animations[:right]
    @speed = 3
  end

  def run
    @speed = 4
  end

  def reset
    spawn = game_state.tiles.spawn
    set_spawn spawn[0], spawn[1]
    die
  end

  def fireball
    return if @dying
    return unless @can_fire
    Fireball.create(x: x, y: y - 8, direction: @direction)
  end

  def jump
    return if @jumping
    @jumping = true

    self.velocity_y = -10
  end

  def move(x, y)
    self.y += y

    return unless collidable

    self.x += x

    tiles = game_state.tiles.tiles_around_object(self)
    each_collision(tiles) do |_me, _stone_wall|
      self.x = previous_x
      break
    end
  end

  def set_spawn(x, y)
    @spawn_x = x
    @spawn_y = y
  end

  def die
    self.collidable = false # Stops further collisions in each_collsiion() etc - so fall off map!.
    @dying = true
    after(500) do
      self.x = @spawn_x
      self.y = @spawn_y
      self.collidable = true
      @dying = false
    end
  end

  def update
    @image = @animation.next

    return unless game_state.tiles

    tiles = game_state.tiles.tiles_around_object(self)
    each_bounding_box_collision(tiles) do | _me, tile |
      break if tile.instance_of? JumpPad

      if velocity_y < 0  # Hitting the ceiling
        self.y = tile.bb.bottom + image.height * factor_y
        self.velocity_y = 0
      else  # Land on ground
        @jumping = false
        self.y = tile.bb.top - 1
      end

      set_spawn self.x, self.y unless @hardcore
    end

    each_bounding_box_collision(Lava) do |_me, _lava|
      die

      break if @hardcore

      if @direction == :right
        set_spawn @spawn_x - @speed, @spawn_y
      else
        set_spawn @spawn_x + @speed, @spawn_y
      end
      break
    end

    each_bounding_box_collision(Door) do | _, _ |
      if @bloodlust && Enemy.all_enemies.count > 0
        game_state.notify 'There are enemies to kill'
      else
        game_state.next_level
        @can_fire = false
        game_state.notify 'Level complete'
      end
    end

    each_bounding_box_collision(Coin) do | _, coin |
      coin.die
    end

    each_bounding_box_collision(PowerUp) do | _, item |
      item.die
      @can_fire = true
      game_state.notify 'Press X to fire'
    end

    each_bounding_box_collision(Enemy.all_enemies) do |_me, _enemy|
      if bb.bottom < _enemy.bb.bottom
        _enemy.die
        self.velocity_y = -4
      else
        die
      end
      break
    end

    each_bounding_box_collision(JumpPad) do | _, tile |
      if velocity_y < 0
        self.y = tile.bb.bottom + image.height * factor_y
        self.velocity_y = 0
      else
        @jumping = false
        self.velocity_y = -20
        self.y = tile.bb.top - 1
      end
    end

    unless game_state.viewport.inside_game_area? self
      die
    end

    @animation = @animations[:none] unless moved?
  end
end
