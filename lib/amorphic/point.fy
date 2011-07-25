class Amorphic {
  class Point {
    read_write_slots: ['coords, 'x, 'y]
    def initialize: @coords ((0,0)) {
      @x, @y = @coords
    }

    def in_rect?: rect {
      r_x, r_y, r_height, r_width = rect get_slots: ['x, 'y, 'height, 'width]
      ((@x >= r_x) && (@x <= (r_x + r_width))) && {
        ((@y >= r_y) && (@y <= (r_y + r_height)))
      }
    }

    def at: idx {
      @coords at: idx
    }
  }
}