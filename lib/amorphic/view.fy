class Amorphic {
  class View {
    include: Gl

    read_write_slots: ['width, 'height, 'z_order, 'gui, 'material, 'background_color, 'rect, 'before_draw]
    read_slots: ['parent, 'texture]

    def initialize: @rect texture: @texture (nil) material: @material (nil) has_border: @has_border (false) {
      { @rect = @rect to_rect } if: (@rect is_a?: Tuple)
      @active_color = nil
      @inactive_color = nil
      @is_active = false
      @is_auto_calc = false
      @needs_redraw = false
      @is_visible = true
      @subviews = []
      @background_color = Color White
      @gui = GUI singleton
    }

    def copy {
      view = self class new
      self slots each: |s| {
        view set_slot: s value: (get_slot: s)
      }
      view
    }

    def draw {
      { @before_draw call: [self] } if: @before_draw

      if: visible? then: {
        x1, x2 = @rect left, @rect right
        y1, y2 = @rect top, @rect bottom

        glDisable(GL_LIGHTING)
        if: @background_color then: {
          r, g, b = @background_color r, @background_color g, @background_color b
          glColor3f(r / 255.0,
                    g / 255.0,
                    b / 255.0)
        } else: {
          glColor3d(1, 1, 1)
        }

        glBegin(GL_QUADS)
           glVertex2f(x1, y1)
           glVertex2f(x2, y1)
           glVertex2f(x2, y2)
           glVertex2f(x1, y2)
        glEnd()

        # draw subviews
        @subviews each: |sv| {
          sv draw
        }
      }
    }

    def position {
      @rect position
    }

    def has_border? {
      @has_border
    }
    def has_border: @has_border

    def destroy
    def resize: rect
    def on_key_down: key sender: sender (nil);
    def on_key_up: key sender: sender (nil);
    def on_move: x y: y {
      @rect x: (@rect x + x)
      @rect y: (@rect y + y)
    }

    def on_mouse_enter
    def on_mouse_leave

    def on_mouse_move: x y: y {
      if: (x == 0 && (y == 0)) then: {
        return false
      }
      retval = false
      @subviews reverse_each: |sv| {
        retval = retval || (sv on_mouse_move: x y: y)
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

          mouse = InputEngine singleton mouse
          prev_pos, curr_pos = mouse prev_cursor_pos, mouse cursor_pos
          was_in_rect = prev_pos in_rect?: @rect
          in_rect = curr_pos in_rect?: @rect
          if: (was_in_rect xor: in_rect) then: {
            if: was_in_rect then: {
              on_mouse_leave
            } else: {
              on_mouse_enter
            }
          }

          if: ((x,y) in_rect?: @rect) then: {
            retval = true
          }
        }
      }
      return retval
    }

    def on_mouse_enter

    def on_lmouse_up: position {
      @gui unlock!
      @subviews reverse_each: |sv| {
        if: (sv on_lmouse_up: position) then: {
          return true
        }
      }
      unless: gui? do: {
        if: (position in_rect?: @rect) then: {
          @gui post_message: self receiver: nil message: 'aquire_focus
          return true
        }
      }
      return false
    }

    def on_lmouse_down: position {
      if: visible? then: {
        @subviews reverse_each: |sv| {
          if: (sv on_lmouse_down: position) then: {
            return true
          }
        }

        unless: gui? do: {
          if: (position in_rect?: @rect) then: {
            @gui active_element: self
            @gui bring_to_front: self
            @gui lock!
            return true
          }
        }
      }
      return false
    }

    def on_rmouse_up: position
    def on_rmouse_down: position

    def view_by_index: index
    def view_by_type: view_type
    def view_count
    def z_order: new_z_order
    def z_order

    def hide {
      @is_visible = false
      @gui push_to_back: self
    }
    def show {
      @is_visible = true
    }
    def visible? {
      @is_visible
    }

    def parent: @parent
    def add_view: subview {
      @subviews << subview
      subview gui: @gui
      subview parent: self
    }
    def remove_view: subview {
      @subviews remove: subview
    }
    def subview?: element {
      @subviews include?: element
    }

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

    def gui? {
      @gui == self
    }
  }
}