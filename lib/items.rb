class Coin < GameObject
  trait :bounding_box, debug: false
  traits :collision_detection, :effect, :timer

  def setup
    @animations = Chingu::Animation.new(file: 'media/items_16x16.png')
    @animations.frame_names = { coin: 4..7 }
    @animation = @animations[:coin]

    self.zorder = 300
    # update
    @image = @animation.next
    cache_bounding_box
  end

  def die
    self.collidable = false # Stops further collisions in each_collsiion() etc.
    self.fade_rate = -3
    after(100) { destroy }
  end

  def draw
    if game_state.viewport.inside? self
      super
    end
  end

  def update
    @image = @animation.next
  end
end

class PowerUp < GameObject
  trait :bounding_box, debug: false
  traits :collision_detection, :effect, :timer

  def setup
    @animations = Chingu::Animation.new(file: 'media/items_16x16.png')
    @animations.frame_names = { power: 0..2 }
    @animation = @animations[:power]

    self.zorder = 300
    # update
    @image = @animation.next
    cache_bounding_box
  end

  def die
    self.collidable = false # Stops further collisions in each_collsiion() etc.
    self.fade_rate = -3
    after(100) { destroy }
  end

  def draw
    if game_state.viewport.inside? self
      super
    end
  end

  def update
    @image = @animation.next
  end
end
