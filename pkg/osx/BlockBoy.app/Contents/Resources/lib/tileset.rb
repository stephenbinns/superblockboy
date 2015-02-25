class Tileset
  attr_reader :spawn
  def initialize(options = {}, game_state)
    @block_height = options[:block_height] || 16
    @block_width = options[:block_width] || 16
    filename = options[:filename]
    tileset_name = options[:tileset_name] || 'tiles'

    @tileset = Image.load_tiles($window, "media/#{tileset_name}.png", @block_height, @block_width, true)
    @lines = File.readlines(filename).map(&:chomp)

    @height = @lines.size
    @width = @lines[0].split(',').length

    game_state.viewport.game_area = [0, 0, (@width - 0.5) * @block_width, (@height - 0.5) * @block_height]
  end

  def load
    @tiles = Array.new(@height) do |y|
      blocks = @lines[y].split ','
      Array.new(@width) do |x|
        block = blocks[x].to_i
        b_x, b_y  = x * @block_width, y * @block_height

        if [8, 10, 11, 16, 17, 19, 51, 52, 53, 54, 55, 56, 57, 44].any? { |b| b == block }
          Background.create(x: b_x, y: b_y, image: @tileset[block])
        elsif [4, 5, 12, 45].any? { |b| b == block }
          Lava.create(x: b_x, y: b_y, image: @tileset[block])
        elsif block == 20
          JumpPad.create(x: b_x, y: b_y, image: @tileset[block])
        elsif block == 47
          Door.create(x: b_x, y: b_y, image: @tileset[block])
        elsif block == 60
          @spawn = [b_x, b_y]
          nil
        elsif block == 62
          Bouncer.create(x: b_x, y: b_y)
          nil
        elsif block == 61
          Walker.create(x: b_x, y: b_y)
          nil
        elsif block == 63
          Flyer.create(x: b_x, y: b_y)
          nil
        elsif block == 64 || block == 65
          ChangeDirectionTile.create(x: b_x, y: b_y, image: @tileset[9])
        elsif block == 66
          Coin.create(x: b_x, y: b_y)
          nil
        elsif block == 67
          PowerUp.create(x: b_x, y: b_y)
          nil
        elsif [9, 18].any? { |b| b == block }
          # special case don't bother rendering a tile
          # the same color a background
        else
          Block.create(x: b_x, y: b_y, image: @tileset[block])
        end
      end.freeze
    end.freeze
  end

  def tile_at_object(object, direction = :center)
    ox, oy = object.bb.midbottom[0], object.bb.midbottom[1]

    if direction == :left
      ox -= @block_width
    elsif direction == :right
      ox += @block_width
    elsif direction == :below
      oy += @block_height
    elsif direction == :above
      oy -= @block_height
    end

    tile_at(ox, oy)
  end

  def tiles_around_object(object)
    ox, oy = object.bb.midbottom[0], object.bb.midbottom[1]
    [
      tile_at(ox, oy),
      tile_at(ox, oy + @block_height),
      tile_at(ox, oy - @block_height)
    ].select { |f| f && f.solid }
  end

  def tile_at(x, y)
    x += x % @block_width
    y += y % @block_height

    y = (y / @block_height).to_i
    x = (x / @block_width).to_i

    return if y > @height - 1
    return if x > @width - 1

    begin
      @tiles[y][x]
    rescue => e
      puts "Error getting tile: #{x} #{y} - #{e}"
      nil
    end
  end
end
