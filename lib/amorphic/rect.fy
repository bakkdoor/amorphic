class Amorphic {
  class Rect {
    read_write_slots: ['x, 'y, 'width, 'height]

    def initialize: position width: @width height: @height {
      @x, @y = position
    }

    def initialize: left right: right top: top bottom: bottom {
      @x, @y = left, top
    }

    def initialize: position size: size {
      width, height = size
      initialize: position width: width height: height
    }

    def position {
      (@x, @y)
    }

    def left {
      @x
    }

    def right {
      @x + @width
    }

    def top {
      @y
    }

    def bottom {
      @y + @height
    }
  }
}