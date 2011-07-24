require: "input/mouse"
require: "input/keyboard"

class Amorphic {
  class InputEngine {
    read_slots: ['keyboard, 'mouse]
    def InputEngine create {
      @@singleton = InputEngine new
    }
    def InputEngine singleton {
      @@singleton
    }

    def initialize {
      @mouse = Input Mouse new
      @keyboard = Input Keyboard new
    }
  }
}