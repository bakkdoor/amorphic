class Amorphic {
  RGBA = Struct new: ['r, 'g, 'b, 'a]

  class Rubinius Tuple {
    def to_rgba {
      RGBA new: self
    }
  }

  class Color {
    @@colors = <[
      'red => (255, 0, 0, 0),
      'green => (0, 255, 0, 0),
      'blue => (0, 0, 255, 0),
      'white => (255, 255, 255, 0),
      'black => (0, 0, 0, 0),
      'grey => (85, 85, 85, 0)
    ]>

    Red = @@colors['red] to_rgba
    Green = @@colors['green] to_rgba
    Blue = @@colors['blue] to_rgba
    White = @@colors['white] to_rgba
    Black =@@colors['black] to_rgba
    Grey = @@colors['grey] to_rgba
  }
}