class Tileset
  def initialize(options = {})
    @block_height = options[:block_height] || 16
    @block_width = options[:block_width] || 16
    filename = options[:filename]
    tileset_name = options[:tileset_name] || "tiles"

    @tileset = Image.load_tiles($window, "media/#{tileset_name}.png", @block_height, @block_width, true)
    @lines = File.readlines(filename).map { |line| line.chomp }

    @height = @lines.size
    @width = @lines[0].split(',').length
  end

  def load
    @tiles = Array.new(@height) do |y|
      blocks = @lines[y].split ','
      Array.new(@width) do |x|
        block = blocks[x].to_i
        b_x, b_y  = x * @block_width, y * @block_height

        if [8,9,10,11,16,17,18,19].any? { |b| b == block }
          Background.create(:x => b_x, :y => b_y, :image => @tileset[block])
        elsif [4,5,12].any? { |b| b == block }
          Lava.create(:x => b_x, :y => b_y, :image => @tileset[block]) 
        else
          Block.create(:x => b_x, :y => b_y, :image => @tileset[block])
        end
      end
    end
  end

  def tile_at_object(object, direction = :center)
    if object.respond_to? :bb
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
    else
      raise 'Object does not respond to bb'
    end
  end

  def tiles_around_object(object)
    [
      tile_at_object(object, :center),
      tile_at_object(object, :left),
      tile_at_object(object, :right),
      tile_at_object(object, :above),
      tile_at_object(object, :below),
    ].select {|f| f.instance_of? Block}
  end

  def tile_at(x, y)
    x += x % @block_width 
    y += y % @block_height

    y = y / @block_height
    x = x / @block_width

    return if y > @tiles.length
    return if x > @tiles[0].length

    begin
      @tiles[y][x]
    rescue
      puts "Error getting tile: #{x} #{y}"
      nil
    end
  end
end