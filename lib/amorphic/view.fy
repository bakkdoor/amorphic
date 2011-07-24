class Amorphic {
  class View {
    read_write_slots: ['width, 'height, 'z_order, 'gui, 'material]
    read_slots: ['position, 'parent, 'texture]

    # virtual int Create(CGUIElement *pParent, tRect WidgetRect, CTexture *pTexture = NULL,
    # CMaterial *pMaterial = NULL, bool bBorder = false);

    def initialize: @parent rect: @rect texture: @texture (nil) material: @material (nil) has_border: @has_border (false) {
      @active_color = nil
      @inactive_color = nil
      @is_active = false
      @is_auto_calc = false
      @needs_redraw = false
    }

    def draw {
      { return nil } unless: visible?
      left, right, top, bottom = @rect get_slots: ['left, 'right, 'top, 'bottom]
      unless: @texture do: {
        glDisable(GL_TEXTURE_2D)
        if: @material do: {
          glDisable(GL_LIGHTNING)
          glColor4fv(@material ambient rgba);
        } else: {
          glDisable(GL_LIGHTNING)
          glColor3d(255,255,255)
        }
        glBegin(GL_QUADS)
        glVertex3d(left, bottom, 0)
        glVertex3d(right, bottom, 0)
        glVertex3d(right, top, 0)
        glVertex3d(left, top, 0)
        glEnd()
      } else: {
        m_pTexture bind

        if: @material then: {
          glDisable(GL_LIGHTING)
          glColor3f(@material ambient r / 255.0,
                    @material ambient g / 255.0,
                    @material ambient g / 255.0)
          # m_pMaterial bind
        } else: {
          glColor3d(1, 1, 1)
        }

        if: (@texture masked?) then: {
          glAlphaFunc(GL_GREATER, 0.0)
          glEnable(GL_ALPHA_TEST)
        }

        glBegin(GL_QUADS)
        #				Bottom Left	Bottom Left
        glTexCoord2f(m_TexCoord[0] x, m_TexCoord[0] y)
        glVertex3d(left, bottom, 0)
        #				Bottom Right is Bottom Left	Bottom Right
        glTexCoord2f(m_TexCoord[1] x, m_TexCoord[1] y)
        glVertex3d(right, bottom, 0)
        #				Top Right is Bottom Right	Top Right
        glTexCoord2f(m_TexCoord[2] x, m_TexCoord[2] y)
        glVertex3d(right, top, 0)
        #				Top Left is Top Right	Top Left
        glTexCoord2f(m_TexCoord[3] x, m_TexCoord[3] y)
        glVertex3d(left, top, 0)
        glEnd()

        if: (@texture masked?) then: {
          glDisable(GL_ALPHA_TEST);
        }
      }

      # draw children
      @children each: |c| {
        c draw
      }
    }

    def has_border? {
      @has_border
    }
    def has_border: @has_border

    def destroy
    def resize: rect
    def on_key_down: key sender: sender (nil);
    def on_key_up: key sender: sender (nil);
    def on_move: x y: y

    def on_mouse_move: x y: y {
      if: (x == 0 && (y == 0)) then: {
        return false
      }
      retval = false
      @children reverse_each: |c| {
        retval = retval || (c on_mouse_move: x y: y)
      }

      unless: gui? do: {
        if: visible? then: {
          if: (@gui locked?) then: {
            cursor_pos = InputEngine singleton mouse cursor_pos
            prev_cursor_pos = InputEngine singleton mouse prev_cursor_pos
            if: (@gui active_element == self) then: {
              on_move: (cursor_pos x - (prev_cursor_pos x)) y: (cursor_pos y - (prev_cursor_pos y))
              return true
            }
          }

          if: (Point new: (x,y) in_rect?: @rect) then: {
            retval = true
          }
        }
      }
      return retval
    }

    def on_lmouse_up: position {
      @children reverse_each: |c| {
        if: (c on_lmouse_up: position) then: {
          return true
        }
      }
      unless: is_guy? do: {
        if: (position in_rect?: @rect) then: {
          @gui post_message: self receiver: nil message: 'aquire_focus
          return true
        }
      }
      return false
    }

    def on_lmouse_down: position
    def on_rmouse_up: position
    def on_rmouse_down: position

    def child_by_index: index
    def child_by_type: view_type
    def child_count
    def remove_child: child_view
    def z_order: new_z_order
    def z_order

    def hide {
      @is_visible = false
    }
    def show {
      @is_visible = true
    }
    def visible? {
      @is_visible
    }

    def parent: parent
    def child?: element

    def auto_calc? {
      @is_auto_calc
    }
    def auto_calc: @is_auto_calc

    def active? {
      @is_active
    }
    def activate {
      @is_active = true
    }
    def deactivate {
      @is_active = false
    }

    def needs_redraw? {
      @needs_redraw
    }
    def needs_redraw: @needs_redraw
  }
}