class Amorphic {
  RGBA = Struct new: ['r, 'g, 'b, 'a]

  class RGBA {
    def darkened_by: amount {
      r = @r - amount max: 0
      g = @g - amount max: 0
      b = @b - amount max: 0
      RGBA new: [r,g,b,0]
    }

    def lightened_by: amount {
      r = @r + amount max: 0
      g = @g + amount max: 0
      b = @b + amount max: 0
      RGBA new: [r,g,b,0]
    }
  }

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