class Amorphic {
  class Views {
    class Label : View {
      read_write_slot: 'text

      def initialize: @text rect: @rect {
        initialize: @rect
        @text_view = TextView new: @text position: (@rect x, @rect y + (@rect height / 2))
        add_view: @text_view
      }
    }
  }
}