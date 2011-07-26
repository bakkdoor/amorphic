class Amorphic {
  class Views {
    class TextView : View {
      def initialize: @text position: @pos {
        initialize: (@pos to_rect)
        @text_color = Color Black
      }

      def draw {
        super draw

        glColor3f(@text_color r / 255.0,
                  @text_color g / 255.0,
                  @text_color g / 255.0)

        glRasterPos2d(text_x, text_y + (@padding / 2))
        text each_byte() |b| {
          glutBitmapCharacter(GLUT_BITMAP_HELVETICA_18, b)
        }
      }
    }
  }
}