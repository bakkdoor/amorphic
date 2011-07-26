class Amorphic {
  class Views {
    class TextView : View {
      read_write_slots: ['text, 'pos]
      def initialize: @text position: @pos {
        initialize: (@pos to_rect)
        @text_color = Color Black
      }

      def draw {
        super draw

        glColor3f(@text_color r / 255.0,
                  @text_color g / 255.0,
                  @text_color g / 255.0)


        glRasterPos2d(@pos x, @pos y)
        @text each_byte() |b| {
          glutBitmapCharacter(GLUT_BITMAP_HELVETICA_18, b)
        }
      }
    }
  }
}