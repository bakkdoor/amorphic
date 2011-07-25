class Amorphic {
  class GUI : View {
    # Add GL and GLUT namespaces in to make porting easier
    include: Gl
    include: Glu
    include: Glut

    read_slot: 'window

    def GUI create {
      @@gui = GUI new
    }

    def GUI singleton {
      @@gui
    }

    # Placeholder for the window object
    def initialize {
      @gui = self
      @children = []
      @bgcolor = RGBA new: (0.7,0.7,0.7,0)
    }

    def setup_event_hooks {
      glut: 'display is: 'draw
      glut: 'reshape is: 'reshape:height:
      glut: 'idle is: 'idle
    }

    def init_gl_window: @width (640) height: @height (480) {
      glutInit()
      glutInitDisplayMode(GLUT_RGB | GLUT_DOUBLE | GLUT_ALPHA | GLUT_DEPTH)
      glutInitWindowSize(@width, @height)
      glutInitWindowPosition(0, 0)
      @window = glutCreateWindow("humble beginnings")
      setup_event_hooks

      # Enable smooth color shading
      glShadeModel(GL_SMOOTH)
    }

    def reshape: @width height: @height {
      { @height = 1 } if: $ @height == 0

      # Reset current viewpoint and perspective transformation
      glViewport(0, 0, @width, @height)

      glMatrixMode(GL_PROJECTION)
      glLoadIdentity()

      gluPerspective(45.0, @width / @height, 0.1, 100.0)
    }


    def draw {
      glMatrixMode(GL_PROJECTION)
      glLoadIdentity()
      glOrtho(0, @width, @height, 0, 0, 1)
      glDisable(GL_DEPTH_TEST)
      glMatrixMode(GL_MODELVIEW)
      glLoadIdentity()
      # Displacement trick for exact pixelization
      glTranslatef(0.375, 0.375, 0)

      # Draw a scene
      glClearColor(@bgcolor r, @bgcolor g, @bgcolor b, @bgcolor a)
      glClear(GL_COLOR_BUFFER_BIT)

      @children each: |c| {
        c draw
      }

      # Swap buffers for display
      glutSwapBuffers()
    }


    # The idle function to handle
    def idle {
      glutPostRedisplay()
    }

    def glut: glutfunc is: method_name target: receiver (self) {
      glut_method = "glut#{glutfunc to_s capitalize}Func"
      match method_name {
        case Block -> send(glut_method, method_name to_proc)
        case _ -> send(glut_method, receiver method(message_name: method_name) to_proc)
      }
    }

    def main_loop {
      glutMainLoop()
    }

    def post_message: sender receiver: receiver message: msg {
      "got message: #{msg} from: #{sender} receiver: #{receiver}" println
    }
  }
}