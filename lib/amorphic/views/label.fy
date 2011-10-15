class Amorphic {
  class Views {
    class Label : View {
      read_write_slot: ['text, 'padding]

      def initialize: @text rect: @rect {
        initialize: @rect
        @padding = 5
        @text_view = TextView new: @text position: (@rect x, @rect y + (@rect height / 2))
        add_view: @text_view
      }

      def padding: @padding {
        @text_view rect: (@text_view rect + (@padding, @padding, @padding * -1, @padding * -1))
      }
    }
  }
}