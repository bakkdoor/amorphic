class Amorphic {
  class Views {
    class Menus {
      class ContextMenu : View {
        def initialize: @entries position: pos {
          rect = (pos + (10,10))
          initialize: rect
          @button = Button new: "Context menu" rect: rect
        }
        def gui: gui {
          super gui: gui
          add_child: @button
        }
        def on_lmouse_up: position {
          if: (super on_lmouse_up: position) then: {
            @gui remove_context_menu: false
            return true
          }
          @gui remove_context_menu: true
          return false
        }
      }
    }
  }
}