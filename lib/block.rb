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