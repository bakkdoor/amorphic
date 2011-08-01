require: "../lib/amorphic"

FancySpec describe: Amorphic Point with: {
  it: "creates a point with a x and y value" when: {
    p = (0,0)
    p x is: 0
    p y is: 0
    p is_a?: Amorphic Point . is: true
  }

  it: "allows setting the x and y values" when: {
    p = (10,20)
    p x is: 10
    p x: 20
    p x is: 20
    p is: (20,20)
    p y: 0
    p is: (20,0)
  }
}