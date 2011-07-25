class Amorphic {
  class Rect {
    read_slots: ['x, 'y, 'left, 'right, 'top, 'bottom, 'position, 'width, 'height]
    def initialize: @position width: @width height: @height {
      @left, @right = @position x, @position x + @width
      @top, @bottom = @position y, @position y + @height
      @x, @y = @position
    }
    def initialize: @left right: @right top: @top bottom: @bottom {
      @x, @y = @left, @top
      @position = (@x, @y)
    }
  }
}