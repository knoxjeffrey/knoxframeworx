require 'spec_helper'

module Knoxframeworx
  
  describe Router do
    
    describe "::controller_and_action_for_path" do
      
      context "when there is no path" do
        
        subject { Router.controller_and_action_for_path("/") }
        
        it "returns home as the controller name" do
          expect(subject.first).to eql(:home)
        end
    
        it "returns the controller action as index" do
          expect(subject.last).to eql(:index)
        end
        
      end
    
      context "when path is only resource name" do
    
        subject { Router.controller_and_action_for_path("/users") }
      
        it "returns the controller name" do
          expect(subject.first).to eql(:users)
        end
    
        it "returns the controller action as index" do
          expect(subject.last).to eql(:index)
        end
        
      end
      
      context "when path contains id only" do
    
        subject { Router.controller_and_action_for_path("/users/1") }
      
        it "returns the controller name" do
          expect(subject.first).to eql(:users)
        end
    
        it "returns the controller action as show" do
          expect(subject.last).to eql(:show)
        end
        
      end
      
      context "when path contains id and action too" do
    
        subject { Router.controller_and_action_for_path("/users/1/show") }
      
        it "returns the controller name" do
          expect(subject.first).to eql(:users)
        end
    
        it "returns the controller action as index" do
          expect(subject.last).to eql(:show)
        end
        
      end

      context "when path is invalid" do
    
        subject { Router.controller_and_action_for_path("/users/show") }
        
        it "returns the controller name as :error" do
          expect(subject.first).to eql(:error)
        end
    
        it "returns the controller action as :not_found" do
          expect(subject.last).to eql(:not_found)
        end
        
      end
      
    end
  
  end
  
end