class Fireball < GameObject
  trait :bounding_box, debug: false, scale: 0.5
  traits :collision_detection, :velocity, :timer

  def setup
    @animations = Chingu::Animation.new(file: 'items_16x16.png')
    @animations.frame_names = { fire: 8..11 }

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
    tiles = game_state.tiles.tiles_around_object(self)
    each_collision(tiles) do | _, tile |
      if y > tile.bb.top
        self.velocity_x *= -1
        self.factor_x *= -1
      else
        self.velocity_y = -5
      end
    end

    each_collision(Enemy.all_enemies) do | me, enemy |
      me.destroy
      enemy.die
    end
  end
end
