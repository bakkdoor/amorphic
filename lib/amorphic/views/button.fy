class Amorphic {
  class Views {
    class Button : View {
      read_write_slots: ['text, 'text_color]
      def initialize: @text rect: @rect texture: @texture (nil) material: @material (nil) has_border: @has_border (false) {
        initialize: @rect texture: @texture material: @material has_border: @has_border
        @on_click_handlers = []
        @text_color = RGBA new: (0.0, 0.0, 0.0, 0.0)
      }

      def draw {
       super draw
        glColor3f(@text_color r / 255.0,
                  @text_color g / 255.0,
                  @text_color g / 255.0)
	      glRasterPos2d(@rect x, @rect y)
        "Hello world" each_byte() |b| {
          glutBitmapCharacter(GLUT_BITMAP_HELVETICA_18, b)
        }
      }

      def on_lmouse_up: position {
        if: @orig_bg_color then: {
          background_color: @orig_bg_color
          @orig_bg_color = nil
        }
        if: (position in_rect?: @rect) then: {
          on_click
          return true
        }
        return false
      }

      def on_lmouse_down: position {
        if: (position in_rect?: @rect) then: {
          on_lmouse_down
          return true
        }
        return true
      }

      def on_click {
        @on_click_handlers each: |h| {
          h call: [self]
        }
        if: @orig_bg_color then: {
          background_color: @orig_bg_color
          @orig_bg_color = nil
        }
      }

      def on_click: handler {
        @on_click_handlers << handler
      }

      def on_lmouse_down {
        # change background color
        unless: @orig_bg_color do: {
          @orig_bg_color = background_color
          new_color = @orig_bg_color darkened_by: 50
          background_color: new_color
        } else: {
          background_color: @orig_bg_color
          @orig_bg_color = nil
        }
      }
    }
  }
}