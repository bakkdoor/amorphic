class Amorphic {
  class Views {
    class Button : View {
      read_write_slots: ['text, 'text_color, 'padding]
      def initialize: @text rect: @rect texture: @texture (nil) material: @material (nil) has_border: @has_border (false) {
        initialize: @rect texture: @texture material: @material has_border: @has_border
        @on_click_handlers = []
        @text_color = RGBA new: (0.0, 0.0, 0.0, 0.0)
        @padding = 10
        if: (@rect width == 0) then: {
          @rect width: (@text size * 12)
          @rect height: (18 + @padding)
        }
      }

      def draw {
        super draw
        if: visible? then: {
          glColor3f(@text_color r / 255.0,
                    @text_color g / 255.0,
                    @text_color g / 255.0)

          text_x = @rect x + @padding
          text_y = @rect y + (@rect height / 2)

          # TODO: get rid of magic numbers
          text = @text
          if: (@text size * 18 > (@rect width)) then: {
            max_letters = @rect width / 12
            text = @text from: 0 to: (max_letters to_i)
          }

          glRasterPos2d(text_x, text_y + (@padding / 2))
          text each_byte() |b| {
            glutBitmapCharacter(GLUT_BITMAP_HELVETICA_18, b)
          }
        }
      }

      def on_lmouse_up: position {
        if: visible? then: {
          if: @orig_bg_color then: {
            background_color: @orig_bg_color
            @orig_bg_color = nil
          }
          if: (position in_rect?: @rect) then: {
            handle_on_click
            return true
          }
        }
        return false
      }

      def on_lmouse_down: position {
        super on_lmouse_down: position
        if: visible? then: {
          if: (position in_rect?: @rect) then: {
            handle_on_lmouse_down
            return true
          }
        }
        return false
      }

      def handle_on_click {
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

      def on_mouse_enter {
        background_color: (background_color lightened_by: 20)
      }

      def on_mouse_leave {
        background_color: (background_color darkened_by: 20)
      }

      def handle_on_lmouse_down {
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