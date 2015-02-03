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
    tiles = self.game_state.tiles.tiles_around_object(self)
    self.each_collision(tiles) do | me, tile |
      if self.y > tile.bb.top
        self.velocity_x = -5
      else
        self.velocity_y = -5
      end
    end
  end
end