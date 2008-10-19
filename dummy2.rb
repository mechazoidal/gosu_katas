class Dummy2 < SubApp
  def initialize(main, game_getter, game_creator)
    super(main)
    @game_getter = game_getter
    @game_creator = game_creator
    @font = Gosu::Font.new(@main, Gosu::default_font_name, 40)
  end
  
  def draw
    game = @game_getter.call
    game.draw if game
    @main.draw_line(400, 0, Gosu::Color.new(0xffffffff), 400, 600, Gosu::Color.new(0xffffffff))
    @main.draw_line(0, 300, Gosu::Color.new(0xffffffff), 800, 300, Gosu::Color.new(0xffffffff))
    
    @main.draw_triangle(, 0, Gosu::Color.new(0x0000ffff), 800, 600, Gosu::Color.new(0x0000ffff), 0, 480, Gosu::Color.new(0x00ffffff))
    # draw(text, x, y, z, factor_x=1, factor_y=1, color=0xffffffff, mode=:default)
    @font.draw("I'm another layer!!", 300, 200, 1, 1.0, 1.0, 0xffffff00)
    
  end
  
  def show()
    super
    @error = 0
  end

  def button_up(button_id)
    case button_id
      when *Buttons[:Escape] then
        close
    end
  end
  
end