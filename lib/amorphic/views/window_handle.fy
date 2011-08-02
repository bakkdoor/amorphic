class Amorphic {
  class Views {
    class WindowHandle : Label {
      read_write_slot: 'text

      def initialize: @text rect: @rect window: @window {
        initialize: @text rect: @rect
      }

      def on_move: x y: y {
        super on_move: x y: y
        @movable = false
        @window on_move: x y: y
        @movable = true
      }
    }
  }
}