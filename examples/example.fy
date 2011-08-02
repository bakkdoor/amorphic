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
        @gui add_view: b
      }

      @gui add_view: button
      @gui add_view: show_button
      @gui add_view: hide_button
      @gui add_view: copy_button
      @gui add_view: $ Views TextView new: "Amorphic Gui System, yo." position: (300,300)
      fps_view = Views TextView new: (@gui fps to_s) position: (720,20)
      @count = 0
      fps_view before_draw: {
        if: (@count > 100) then: {
          fps_view text: $ (@gui fps to_s) ++ " FPS"
          @count = 0
        }
        @count = @count + 1
      }
      @gui add_view: fps_view
    }
    def run {
      @gui start
    }
  }
}

app = Amorphic ExampleApp new#: (500,500)
app run