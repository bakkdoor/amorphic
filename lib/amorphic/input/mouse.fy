class Amorphic {
  class Input {
    class Mouse {
      read_slots: ['cursor_pos, 'prev_cursor_pos]
      def initialize {
        @cursor_pos = Point new: (0,0)
        @prev_cursor_pos = @cursor_pos
        # TODO hook up into glut mouse events
      }

      def setup_event_hooks {
      }
    }
  }
}