class ViewPortBlock < GameObject
  trait :bounding_box
  trait :collision_detection

  attr_reader :solid

  def setup
    cache_bounding_box
    @solid = false
  end

  def draw
    super
  end

  def update
  end
end

class Background < ViewPortBlock
end

class Block < ViewPortBlock
  def setup
    super
    @solid = true
  end
end

class ChangeDirectionTile < ViewPortBlock
end

class Door < ViewPortBlock
end

class JumpPad < ViewPortBlock
  def setup
    super
    @solid = true
  end
end

class Lava < ViewPortBlock
  trait :bounding_box, scale: 0.7, debug: false
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
