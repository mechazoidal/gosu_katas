# Taken from "Nightly Travels of a Witch"
class SubApp
  # NOTES: A SubApp is much like a GameState, except that it's responsible for rendering
  # and handling all events itself.
  # That way, the "Main"  is just a stack of "apps" that it can push/pop.
  
  attr_accessor :active, :main

  def inspect()
    self.class.inspect
  end
  
  def initialize(main)
    # main is your parent app, that you should forward your draw requests to.
    @main = main
    @active = false
  end
  
  # Default implementations, override these in your own subapp
  def update(*args) end
  def draw(*args) end
  def button_down(*args) end
  def button_up(*args) end
  def activate(*args) end
  def deactivate(*args) end

  def show()
    @main.push_app(self)
  end

  def close()
    @main.pop_app(self)
  end

  def button_down?(button)
    @main.button_down?(button) if active?
  end

  def active?()
    @active
  end
end