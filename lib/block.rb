class ViewPortBlock < GameObject
  trait :bounding_box, debug: false
  trait :collision_detection

  def setup
    cache_bounding_box
  end

  def draw
    if game_state.viewport.inside? self
      super
    end
  end

  def update
  end
end

class Background < ViewPortBlock
end

class Block < ViewPortBlock
end

class ChangeDirectionTile < ViewPortBlock
end

class Door < ViewPortBlock
end

class JumpPad < ViewPortBlock
end

class Lava < GameObject
  trait :bounding_box, scale: 0.7, debug: false
  trait :collision_detection

  def setup
    cache_bounding_box
  end
end
