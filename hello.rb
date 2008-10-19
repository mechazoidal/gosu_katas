begin
  # In case you use Gosu via RubyGems.
  require 'rubygems'
rescue LoadError
  # In case you don't.
end

require 'gosu'
require 'main'
require 'subapp'
require 'dummy'
require 'dummy2'
include Gosu

# Constants
Buttons = {
  :Fire => [
    Button::KbReturn,
    Button::KbEnter,
    Button::GpButton0,
    Button::MsLeft
  ],
  :Escape => [
    Button::KbEscape,
    Button::GpButton4
  ]
}
game = nil
main = MainApp.new(800, 600, false, 20)
main.caption = "Gosu Katas"
# TODO: find out what Nightly Witch uses the lambda and game var for.
# I _think_ the lambda is used to execute the next subapp. So when the subapp ends, the lambda block does too.
dummy = Dummy.new(main, lambda { game }, lambda { |i| game = Game.new(main, i) })
# The first parameter is the previous subapp? the second is itself?
# This command line only shows Dummy2:
dummy2 = Dummy2.new(main, lambda {game}, lambda { |i| dummy.show })
# This one shows them overlaid.
# dummy2 = Dummy2.new(main, lambda {dummy}, lambda { |i| dummy.show })
# dummy = Dummy.new(main)
# Start the subapp.
dummy2.show
main.show