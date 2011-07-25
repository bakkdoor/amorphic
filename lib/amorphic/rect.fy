class Amorphic {
  class Rubinius Tuple {
    def to_rect {
      if: (size == 4) then: {
        x, y, width, height = self
        Rect new: (x,y) width: width height: height
      } else: {
        Rect new: self width: nil height: nil
      }
    }
  }

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