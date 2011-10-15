class Amorphic {
  class Views {
    class BasicWindow : View {
      read_write_slots: ['title]
      def initialize: @title rect: @rect {
        initialize: @rect

        handle_rect = @rect - (0,40) copy
        handle_rect width: 200
        handle_rect height: 40
        @top_handle = WindowHandle new: @title rect: handle_rect window: self
        @top_handle background_color: Color Grey
        draggable: false
        add_view: @top_handle
      }
    }
  }
}