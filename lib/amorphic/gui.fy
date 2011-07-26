class Amorphic {
  class GUI : View {
    include: Gl
    include: Glu
    include: Glut

    read_slot: 'window
    read_write_slots: ['active_element, 'title]

    def GUI create: size ((640, 480)) {
      @@gui = GUI new: size
    }

    def GUI singleton {
      @@gui
    }

    def initialize: size ((640, 480)) {
      super initialize: $ Rect new: (0,0) size: size
      @width, @height = @rect width, @rect height
      @gui = self
      @children = []
      background_color: $ RGBA new: (200, 200, 200, 0)
      @title = ""
      @last_draw = Time now
    }

    def setup_event_hooks {
      glut: 'display is: 'draw
      glut: 'reshape is: 'reshape:height:
      glut: 'idle is: 'idle
    }

    def init_gl_window {
      glutInit()
      glutInitDisplayMode(GLUT_RGB | GLUT_DOUBLE | GLUT_ALPHA | GLUT_DEPTH)
      glutInitWindowSize(@width, @height)
      glutInitWindowPosition(0, 0)
      @window = glutCreateWindow(@title)

      # smooth color shading
      glShadeModel(GL_SMOOTH)
      @input_engine = InputEngine create: self
      setup_event_hooks
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
      @last_draw = Time now
      glMatrixMode(GL_PROJECTION)
      glLoadIdentity()
      glOrtho(0, @width, @height, 0, 0, 1)
      glDisable(GL_DEPTH_TEST)
      glMatrixMode(GL_MODELVIEW)
      glLoadIdentity()
      # Displacement trick for exact pixelization
      glTranslatef(0.375, 0.375, 0)

      glClearColor((background_color r) / 255.0,
                   (background_color g) / 255.0,
                   (background_color b) / 255.0,
                   background_color a)
      glClear(GL_COLOR_BUFFER_BIT)

      @children each: |c| {
        c draw
      }

      glutSwapBuffers()
    }

    def idle {
      glutPostRedisplay()
    }

    def glut: glutfunc is: method_name target: receiver (self) {
      name = glutfunc to_s
      name = name first capitalize + (name rest)
      glut_method = "glut#{name}Func"
      match method_name {
        case Block -> send(glut_method, method_name to_proc)
        case _ -> send(glut_method, receiver method(message_name: method_name) to_proc)
      }
    }

    def start {
      init_gl_window
      glutMainLoop()
    }

    def post_message: sender receiver: receiver message: msg {
      "got message: #{msg} from: #{sender} receiver: #{receiver}" println
    }

    def locked? {
      @locked
    }
    def lock! {
      @locked = true
    }
    def unlock! {
      @locked = false
    }

    def bring_to_front: child {
      remove_child: child
      add_child: child
    }

    def push_to_back: child {
      remove_child: child
      @children unshift: child
    }

    def fps {
      1 / (Time now - @last_draw) ceil
    }
  }
}