class Amorphic {
  class Input {
    class Keyboard {
      def initialize: @gui {
        # TODO hook up into glut mouse events
      }

      def setup_event_hooks {
        @gui glut: 'keyboard is: 'keyboard:x:y: target: self
      }

      def keyboard: key x: x y: y {
        match key {
          case 27 -> # escape
            glutDestroyWindow(@gui window)
            exit(0)
        }
        Glut glutPostRedisplay()
      }
    }
  }
}