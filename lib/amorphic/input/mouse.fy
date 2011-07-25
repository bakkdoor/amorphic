class Amorphic {
  class Input {
    class Mouse {
      read_slots: ['cursor_pos, 'prev_cursor_pos]
      def initialize: @gui {
        @cursor_pos = (0,0)
        @prev_cursor_pos = @cursor_pos
        # TODO hook up into glut mouse events
      }

      def setup_event_hooks {
        @gui glut: 'mouse is: 'mouse:state:x:y: target: self
        @gui glut: 'entry is: 'entry: target: self
      }

      def mouse: button state: state x: x y: y {
        # "button: #{button} state: #{state} x: #{x} y: #{y}" println
        # { "down!" println } if: (state == GLUT_DOWN)
        # { "up!" println } if: (state == GLUT_UP)
        pos = (x,y)
        match button {
          case GLUT_LEFT_BUTTON ->
            match state {
              case GLUT_DOWN -> @gui on_lmouse_down: pos
              case _ -> @gui on_lmouse_up: pos
            }
          case GLUT_RIGHT_BUTTON ->
            match state {
              case GLUT_DOWN -> @gui on_rmouse_down: pos
              case _ -> @gui on_rmouse_up: pos
            }
          case GLUT_MIDDLE_BUTTON ->
            match state {
              case GLUT_DOWN -> @gui on_mmouse_down: pos
              case _ -> @gui on_mmouse_up: pos
            }
        }
      }

      def entry: state {
        match state {
          case GLUT_LEFT -> "left!" println
          case GLUT_ENTERED -> "entered!" println
        }
      }
    }
  }
}