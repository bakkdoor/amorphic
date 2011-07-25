require("rubygems")
require("opengl")
require("glut")

metaclass include: Gl
metaclass include: Glu
metaclass include: Glut

 def point {
   glBegin(GL_POINTS)
   glVertex2f(@x1 + 0.5, @y1 + 0.5)
   glEnd()
 }

 def line {
   glBegin(GL_LINES)
   glVertex2f(@x1, @y1)
   glVertex2f(@x2, @y2)
   glEnd()
 }

 def rectangle {
   glBegin(GL_QUADS)
   glVertex2f(@x1, @y1)
   glVertex2f(@x2, @y1)
   glVertex2f(@x2, @y2)
   glVertex2f(@x1, @y2)
   glEnd()
 }

 def hollow_rectangle {
   glBegin(GL_LINE_LOOP)
   glVertex2f(@x1, @y1)
   glVertex2f(@x2, @y1)
   glVertex2f(@x2, @y2)
   glVertex2f(@x1, @y2)
   glEnd()
 }

def display {
  XSize = 640
  YSize = 480
  glMatrixMode(GL_PROJECTION)
  glLoadIdentity()
  glOrtho(0, XSize, YSize, 0, 0, 1)
  glDisable(GL_DEPTH_TEST)
  glMatrixMode(GL_MODELVIEW)
  glLoadIdentity()
  # ' Displacement trick for exact pixelization
  glTranslatef(0.375, 0.375, 0)

  # ' Draw a scene
  glClearColor(0.3, 0.3, 0.3, 0)
  glClear(GL_COLOR_BUFFER_BIT)

  @x1 = 20
  @y1 = 20
  @x2 = 620
  @y2 = 460
  hollow_rectangle

  @x1 = 20
  @y1 = 40
  @x2 = 620
  @y2 = 40
  line
  @x1 = 602
  @y1 = 22
  @x2 = 618
  @y2 = 37
  rectangle
  @x1 = 580
  @y1 = 460
  @x2 = 620
  @y2 = 420
  line

  5000 times: {
    @x1 = (rand() % 600) + 20
    @y1 = (rand() % 420) + 40
    point
  }

  glutSwapBuffers()
}
def reshape: width height: height {
    { height = 1 } if: $ height == 0

    # Reset current viewpoint and perspective transformation
    glViewport(0, 0, width, height)

    glMatrixMode(GL_PROJECTION)
    glLoadIdentity()

    gluPerspective(45.0, width / height, 0.1, 100.0)
}

def idle {
    glutPostRedisplay()
}

glutInit()
glutInitDisplayMode(GLUT_RGB | GLUT_DOUBLE | GLUT_ALPHA | GLUT_DEPTH)
glutInitWindowSize(800, 600)
glutInitWindowPosition(0, 0)
@window = glutCreateWindow("humble beginnings")

glutDisplayFunc(method(":display") to_proc)
glutIdleFunc(method(":idle") to_proc)
glutReshapeFunc(method("reshape:height:") to_proc)
"ok" println
glutMainLoop()
