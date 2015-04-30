require 'spec_helper'

module Knoxframeworx
  
  describe ControllerInitializer do
    
    before :all do
      path = File.join(File.dirname(__FILE__), "..", 'dummy', 'app', 'controllers')
      ControllerInitializer.controllers_path = path
    end
    
    let(:controller_name) { :users }
    let(:action_name) { :index }
    let(:env) { { } }
    
    subject { ControllerInitializer.new(controller_name, action_name, env) }
    
    
    context "when controller name is valid and action name is valid" do
      
      it "returns a valid controller instance" do
        expect(subject.controller).to be_an_instance_of(UsersController)
      end
      
      it "sets the corrent status" do
        expect(subject.controller.status).to eq(200)
      end
      
      it "sets the correct headers" do
        expect(subject.controller.headers).to be_an_instance_of(Hash)
        expect(subject.controller.headers).not_to be_empty
      end
      
      it "sets the body with a string" do
        expect(subject.controller.body).to be_an_instance_of(String)
        expect(subject.controller.body).not_to be_empty
      end
      
    end
    
    context "when controller name is valid and action name is not valid" do
      
      let(:action_name) { :oops }
      
      it "returns a ErrorsController instance" do
        expect(subject.controller).to be_an_instance_of(ErrorsController)
      end
      
      it "returns the correct status" do
        expect(subject.controller.status).to eq(404)
      end
    
      it "sets the body with a string" do
        expect(subject.controller.body).to match(/not found/i)
      end
        
    end

    context "when controller name is not valid" do
    
      let(:controller_name) { :crappy }
      
      it "returns a ErrorsController instance" do
        expect(subject.controller).to be_an_instance_of(ErrorsController)
      end
      
      it "returns the correct status" do
        expect(subject.controller.status).to eq(404)
      end
    
      it "sets the body with a string" do
        expect(subject.controller.body).to match(/not found/i)
      end
      
    end
  
  end
  
end
  