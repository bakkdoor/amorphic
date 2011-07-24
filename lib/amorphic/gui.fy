class GUI {
  # Add GL and GLUT namespaces in to make porting easier
  include: Gl
  include: Glu
  include: Glut

  read_slot: 'window

  # Placeholder for the window object
  def initialize {
    # Initliaze our GLUT code
    glutInit()
    # Setup a double buffer, RGBA color, alpha components and depth buffer
    glutInitDisplayMode(GLUT_RGB | GLUT_DOUBLE | GLUT_ALPHA | GLUT_DEPTH)
    glutInitWindowSize(800, 600)
    glutInitWindowPosition(0, 0)
    @window = glutCreateWindow("humble beginnings")
    setup_event_hooks
    @children = []
  }

  def add_child: child {
    @children << child
  }

  def remove_child: child {
    @children remove: child
  }

  def setup_event_hooks {
    glut: 'display is: 'draw_gl_scene
    glut: 'reshape is: 'reshape:height:
    glut: 'idle is: 'idle
  }

  def init_gl_window: width (640) height: height (480) {
      # Background color to black
      glClearColor(0.0, 0.0, 0.0, 0)
      # Enables clearing of depth buffer
      glClearDepth(1.0)
      # Set type of depth test
      glDepthFunc(GL_LEQUAL)
      # Enable depth testing
      glEnable(GL_DEPTH_TEST)
      # Enable smooth color shading
      glShadeModel(GL_SMOOTH)

      glMatrixMode(GL_PROJECTION)
      glLoadIdentity()
      # Calculate aspect ratio of the window
      gluPerspective(45.0, width / height, 0.1, 100.0)

      glMatrixMode(GL_MODELVIEW)

      draw_gl_scene
  }

  def reshape: width height: height {
      { height = 1 } if: $ height == 0

      # Reset current viewpoint and perspective transformation
      glViewport(0, 0, width, height)

      glMatrixMode(GL_PROJECTION)
      glLoadIdentity()

      gluPerspective(45.0, width / height, 0.1, 100.0)
  }


  def draw_gl_scene {
      # Clear the screen and depth buffer
      glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT)

      # Reset the view
      glMatrixMode(GL_MODELVIEW)
      glLoadIdentity()

      # Move left 1.5 units and into the screen 6.0 units
      glTranslatef(-1.5, 0.0, -6.0)

      # Draw a triangle
      glBegin(GL_POLYGON)
          glVertex3f( 0.0,  1.0, 0.0)
          glVertex3f( 1.0, -1.0, 0.0)
          glVertex3f(-1.0, -1.0, 0.0)
      glEnd()

      # Move right 3 units
      glTranslatef(3.0, 0.0, 0.0)

      # Draw a rectangle
      glBegin(GL_QUADS)
          glVertex3f(-1.0,  1.0, 0.0)
          glVertex3f( 1.0,  1.0, 0.0)
          glVertex3f( 1.0, -1.0, 0.0)
          glVertex3f(-1.0, -1.0, 0.0)
      glEnd()

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
}