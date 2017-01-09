class Robot
  attr_accessor :x, :y, :orientation, :placed

  def initialize
    @placed = false
  end

  def place(x, y, orientation)
    @x = x.to_i
    @y = y.to_i
    validate_coordinates(@x, @y)
    @placed = true
    @orientation = orientation
    return "ROBOT has been placed at x: #{@x}, y: #{@y}, facing: #{@orientation}"
  end

  def placed?
    @placed
  end

  def validate_coordinates(x, y)
    if x > 5 || x < 0 || y > 5 || y < 0
      raise OutOfBoundary.new
    end
  end

  def move
    case @orientation
      when "NORTH"
        validate_coordinates(@x, @y+1)
        @y += 1
      when "SOUTH"
        validate_coordinates(@x, @y-1)
        @y -= 1
      when "WEST"
        validate_coordinates(@x-1, @y)
        @x -= 1
      when "EAST"
        validate_coordinates(@x+1, @y)
        @x += 1
    end
  end

  def report
    return "Your Robot is located at x: #{@x}, y: #{@y}, facing: #{@orientation}"
  end

  def left
    @orientation = rotate_left
    puts "Your Robot is now facing #{@orientation}"
  end

  def rotate_left
    { "NORTH" => "WEST",
      "WEST" => "SOUTH",
      "SOUTH" => "EAST",
      "EAST" => "NORTH"
    }[@orientation]
  end

  def right
    @orientation = rotate_right
    puts "Your Robot is now facing #{@orientation}"
  end

  def rotate_right
    { "NORTH" => "EAST",
      "EAST" => "SOUTH",
      "SOUTH" => "WEST",
      "WEST" => "NORTH"
    }[@orientation]
  end

end

class OutOfBoundary < StandardError
end
