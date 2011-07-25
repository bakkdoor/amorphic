require: "lib/amorphic"

class Amorphic {
  class ExampleApp {
    def initialize: @size ((800,600)) {
      @gui = GUI create: @size
      input_engine = InputEngine create: @gui
      rect = Rect new: (10,10) size: (100,100)
      button = Views Button new: "Click.me.please!" rect: rect
      button background_color: $ Color Grey
      button text_color: $ Color White
      button on_click: |sender| {
        "Clicked!" println
      }

      hide_button = Views Button new: "Hide it!" rect: (120, 100)
      hide_button on_click: {
        button hide
      }

      show_button = Views Button new: "Show it!" rect: (220, 100)
      show_button on_click: {
        button show
      }

      @gui add_child: button
      @gui add_child: show_button
      @gui add_child: hide_button
    }
    def run {
      @gui main_loop
    }
  }
}

app = Amorphic ExampleApp new#: (500,500)
app run