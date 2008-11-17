require 'gosu'
include Gosu
# Core app that controls all SubApps in the application.
# TODO: "app" is a misnomer, find a better name.
# Layer? StateLayer?
# Problem is that a Subapp has both a state, a layer, and an exclusive(?) lock on input...
class MainApp < Gosu::Window
  attr_reader :apps
  
  def initialize(*args)
    # super(640, 480, false, 20)
    # self.caption = 'Hello World!'
    @apps = Array.new
    super(*args)
  end
  
  def push_app(app)
    # Push a new app into the main stack and activate it.
    @apps << app
    app.active = true
    app.activate
  end
  
  def pop_app(pop_app)
    # Remove and deactivate an app from the stack.
    app = nil
    
    if(@apps.last == pop_app)
      # If we're removing the last app in the stack, get it by popping @apps.
      # ?: Seems to be redundant(could be coding style)
      app = @apps.pop
      begin
        app.deactivate
      ensure
        # ?: Whatever happens during deactivate, make sure the app being popped is NOT active.
        app.active = false
      end
    else
      # ?: Remove the app from the stack
      # But this isn't reject!, so it doesn't affect @apps..?
      @apps.reject {|x| app = x if pop_app == x}
    end
    # Activate the last app in the stack if there is one.
    @apps.last.activate if @apps.size > 0
  end
  
  def dispatch(method, *args)
    # Send a method and its args to the stack.
    if(@apps.size == 0)
      # no more apps, close the window.
      close
    else
      # Send the method and args to the last app in the stack.
      # This assumes that the last app in the stack is active?
      @apps.last.send(method, *args)
    end
  end
  
  # Attaches the main's draw, update, and button methods to the stack.
  [:draw, :update, :button_down, :button_up].each do |method|
    define_method(method) do |*args|
      dispatch(method, *args)
    end
  end
  
  # These next two methods might be specific to Nightly Travels.
  # ?: seems to be trapping button events to check for mouse events.
  
  # This traps the regular Gosu button_down method..
  alias :old_button_down :button_down
  # ..then redefine it to check for wheel events.
  def button_down(button_id)
    case button_id
      when(Button::MsWheelUp || Button::MsWheelDown)
        button_up(button_id)
      else
        old_button_down(button_id)
    end
  end
  
  # This traps the regular Gosu button_up method..
  alias :old_button_up :button_up
  # ..then redefine it to check for mouse clicks within the window.
  def button_up(button_id)
    case button_id
      when Button::MsLeft, Button::MsMiddle, Button::MsRight then
        if(mouse_x > 0 and mouse_y > 0 and mouse_x < width and mouse_y < height)
          old_button_up(button_id)
        end
      else
        old_button_up(button_id)
    end
  end
  
end