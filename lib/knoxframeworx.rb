require "knoxframeworx/version"
require "knoxframeworx/dependencies"
require "knoxframeworx/utils"
require "knoxframeworx/routing"

module Knoxframeworx
  
  class Application 
    
    def call(env)
      if  env["PATH_INFO"] == '/'
        return [200, {'Content-Type' => 'text/html'}, ["The Visual Page?"] ]
      end
      
      if env["PATH_INFO"] == '/favicon.ico'
        return [500, { }, [] ]
      end
      
      #eg takes /pages/about from env["PATH_INFO"] and returns 
      #controller_class = PagesController
      #action = about
      #In users application PagesController will inherit from Controller class below
      #Instantiates a new PagesController class and invokes the about method
      controller_class, action = get_controller_and_action(env)
      controller = controller_class.new(env)
      
      begin
        response = controller.send(action)
        [ 200, {'Content-Type' => 'text/html'}, [response] ]
      rescue
        [ 404, {'Content-Type' => 'text/html'}, ["No luck, this doesn't exist!"] ]
      end
    end
    
  end
  
  class Controller
    
    def initialize(env)
      @env = env
    end
    
    def env
      @env
    end
  end
  
end
