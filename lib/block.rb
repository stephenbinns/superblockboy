class Block < GameObject
  trait :bounding_box, debug: false
  trait :collision_detection

  def setup
    cache_bounding_box
  end
end

class Background < GameObject
end

class Door < GameObject
  trait :bounding_box, debug: false
  trait :collision_detection

  def setup
    cache_bounding_box
  end
end

class JumpPad < GameObject
  trait :bounding_box, debug: false
  trait :collision_detection

  def setup
    cache_bounding_box
  end
end

class Lava < GameObject
  trait :bounding_box, scale: 0.7, debug: false
  trait :collision_detection

  def setup
    cache_bounding_box
  end
end
