require: "lib/amorphic"

class Amorphic {
  class ExampleApp {
    def initialize: @size ((800,600)) {
      @gui = GUI create: @size
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

      copy_button = Views Button new: "Copy it!" rect: (320, 100)
      last_rect = button rect
      copy_button on_click: {
        b = button copy
        last_rect = last_rect + (10,10)
        b rect: last_rect
        @gui add_child: b
      }

      @gui add_child: button
      @gui add_child: show_button
      @gui add_child: hide_button
      @gui add_child: copy_button
      @gui add_child: $ Views TextView new: "Amorphic Gui System, yo." position: (300,300)
    }
    def run {
      @gui start
    }
  }
}

app = Amorphic ExampleApp new#: (500,500)
app run