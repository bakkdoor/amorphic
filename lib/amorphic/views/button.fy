class Amorphic {
  class Views {
    class Button : View {
      def initialize: @text rect: @rect texture: @texture (nil) material: @material (nil) has_border: @has_border (false) {
        initialize: @rect texture: @texture material: @material has_border: @has_border
      }

      def draw {
       super draw
      }

      def on_lmouse_down: position {
        if: (position in_rect?: @rect) then: {
          "clicked!" println
          return true
        }
        return false
      }
    }
  }
}