require File.expand_path(File.join(File.dirname(__FILE__), "spec_helper"))

describe MainApp do
  before(:each) do
    @main = MainApp.new(800, 600, false, 20)

    # @subapp = SubApp.new(@main)
  end
  describe "when pushing a subapp" do
    it "should set a pushed subapp active" do
      @subapp = mock("SubApp")
      
      @subapp.should_receive(:active=).and_return(true)
      @subapp.should_receive(:activate)
      @main.push_app(@subapp)
    
    end
  end
  describe "when popping a subapp" do
    before(:each) do
      @subapp = mock("SubApp")
      # TODO: how to respond to this?
      @subapp.stub!(:active=).and_return(true)
      # @
      @main.push_app(@subapp)
    end
    it "should deactivate" do
      @subapp.should_receive(:deactivate)      
      @main.pop_app(@subapp)
    end
    it "should activate the last app in the stack if there is one" do
      pending
    end
    it "should exit if there are no subapps remaining in the stack" do
      pending
    end
  end
end