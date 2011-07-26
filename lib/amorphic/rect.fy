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

    def size {
      (@width, @height)
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

    def + other {
      match other {
        case Rect ->
          r = Rect new: position size: size
          ['x, 'y, 'width, 'height] each: |s| {
            r set_slot: s value: $ get_slot: s + (other get_slot: s . to_i)
          }
          r
        case _ -> self + (other to_rect)
      }
    }
  }
}