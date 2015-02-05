class BlockBoy < GameObject
  trait :bounding_box, scale: 1.00, debug: false
  traits :timer, :collision_detection, :velocity

  def setup
    self.input = {
      [:holding_left, :holding_a] => :holding_left,
      [:holding_right, :holding_d] => :holding_right,
      [:up, :w] => :jump,
      [:x] => :fireball
    }

    @animations = Chingu::Animation.new(file: 'player_16x16.png')
    @animations.frame_names = { none: 0..0, left: 4..6, right: 0..3 }

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
    Fireball.create(x: x, y: y - 8, direction: @direction)
  end

  def jump
    return if @jumping
    @jumping = true
    self.velocity_y = -10
  end

  def move(x, y)
    self.x += x
    each_collision(Block) do |_me, _stone_wall|
      self.x = previous_x
      break
    end

    self.y += y
  end

  def update
    @image = @animation.next

    tiles = game_state.tiles.tiles_around_object(self)
    each_collision(tiles) do | _me, tile |
      if velocity_y < 0  # Hitting the ceiling
        self.y = tile.bb.bottom + image.height * factor_y
        self.velocity_y = 0
      else  # Land on ground
        @jumping = false
        self.y = tile.bb.top - 1
      end
    end

    each_collision(Lava) do |_me, _lava|
      self.x = 100
      self.y = 100
      break
    end

    each_collision(Enemy.all_enemies) do |_me, _enemy|
      self.x = 100
      self.y = 100
      break
    end

    @animation = @animations[:none] unless moved?
  end
end
