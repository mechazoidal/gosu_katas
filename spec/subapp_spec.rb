require 'subapp'

# require File.dirname(__FILE__) + '/../spec_helper'

describe SubApp do
  before(:each) do
    # @main = MainApp.new(800, 600, false, 20)
    @main = mock("MainApp")
    
    @subapp = SubApp.new(@main)
  end
  
  describe "when created" do
    it "should not be active" do
      # @subapp.active?
      @subapp.active?.should_not be(true)
    end 
    it "should not capture events" do
      # pending
      
    end
  end
  
  describe "when active" do
    it "should be active" do
      @main.should_receive(:push_app).with(@subapp).once
      
      @subapp.show
      @subapp.active?.should be(true)
    end
  end
end