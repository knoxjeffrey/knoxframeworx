require "knoxframeworx/version"
require "knoxframeworx/dependencies"
require "knoxframeworx/utils"
require "knoxframeworx/routing"
require "knoxframeworx/controller"

module Knoxframeworx
  
  class Application 
    
    def call(env)
      if env["PATH_INFO"] == '/favicon.ico'
        return [500, { }, [] ]
      end
      
      
      #eg takes /pages/about from env["PATH_INFO"] and returns 
      #controller_class = PagesController
      #action = about
      #In users application PagesController will inherit from Controller class below
      #Instantiates a new PagesController class and invokes the about method
      #Root of application needs to have a HomeController with index action
      begin
        if env["PATH_INFO"] == '/'
          controller = HomeController.new(env)
          response = controller.send('index')
        else
          controller_class, action = get_controller_and_action(env)
          controller = controller_class.new(env)
          if action == nil
            response = controller.send('index')
          else
            response = controller.send(action)
          end
        end
        [ 200, {'Content-Type' => 'text/html'}, [response] ]
      rescue
        [ 404, {'Content-Type' => 'text/html'}, ["No luck, this doesn't exist!"] ]
      end
    end
    
  end
  
end
