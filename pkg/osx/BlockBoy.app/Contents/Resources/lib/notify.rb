class Notify
  def age
    (Gosu.milliseconds - @start_time) / 1000.0
  end

  def dead?
    age > @death_time
  end

  def initialize(string, death_time = 1.5, alpha_fade = 4)
    @string = string
    @y = $window.height / 2
    @color = Gosu::Color.new(0xff3c733f)
    @start_time = Gosu.milliseconds
    @alpha_fade = alpha_fade
    @death_time = death_time
  end

  def update
    @color.alpha -= @alpha_fade
  end

  def draw
    @text1 = centered_text(@string, @y, Color.new(0xff0e4612))
    @text2 = centered_text(@string, @y + 2, Color.new(0xff3c733f))
  end

  def destroy
    @text1.destroy
    @text2.destroy
  end

  def centered_text(string, y, color, size = 28)
    text = Text.create(
      y: y,
      x: $window.width / 2,
      font: 'media/bubble.ttf',
      size: size,
      color: color,
      text: string)
    text.x -= @text.image.width / 2
    text.y -= @text.image.height / 2

    text
  end
end
