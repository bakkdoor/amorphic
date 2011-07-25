class Amorphic {
  class Input {
    class Mouse {
      read_slots: ['cursor_pos, 'prev_cursor_pos]
      def initialize: @gui {
        @x, @y = 0, 0
        @p_x, @p_y = 0, 0
        # TODO hook up into glut mouse events
      }

      def cursor_pos {
        (@x, @y)
      }

      def prev_cursor_pos {
        (@p_x, @p_y)
      }

      def setup_event_hooks {
        @gui glut: 'mouse is: 'mouse:state:x:y: target: self
        @gui glut: 'entry is: 'entry: target: self
        @gui glut: 'passiveMotion is: 'passive_motion:y: target: self
        @gui glut: 'motion is: 'passive_motion:y: target: self
      }

      def mouse: button state: state x: x y: y {
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

      def passive_motion: x y: y {
        @p_x, @p_y = @x, @y
        @x, @y = x, y
        @gui on_mouse_move: x y: y
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