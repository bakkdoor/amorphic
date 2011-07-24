require: "input/mouse"
require: "input/keyboard"

class Amorphic {
  class InputEngine {
    read_slots: ['keyboard, 'mouse]
    def InputEngine create: gui {
      @@singleton = InputEngine new: gui
    }
    def InputEngine singleton {
      @@singleton
    }

    def initialize: @gui {
      @mouse = Input Mouse new: @gui
      @keyboard = Input Keyboard new: @gui
      @mouse setup_event_hooks
      @keyboard setup_event_hooks
    }
  }
}