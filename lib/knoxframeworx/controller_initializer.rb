module Knoxframeworx
  
  class ControllerInitializer
    
    attr_reader :controller_name, :action_name, :env
    
    def initialize(controller_name, action_name, env)
      @controller_name = controller_name.to_s
      @action_name = action_name.to_s
      @env = env
    end
    
    def controller
      begin
        load controller_file_path
        controller_class.new(env).tap { |c| c.send(action_name) }
      rescue LoadError #controller not found
        ErrorsController.new(env).tap { |c| c.send(:not_found) }
      rescue #action not found
        ErrorsController.new(env).tap { |c| c.send(:not_found) }
      end
    end
    
    
    def self.controllers_path=(path_name)
      @controllers_path = path_name
    end
    
    def self.controllers_path
      @controllers_path ||= './app/controllers'
    end
    
    private
    
    def controller_class
      Object.const_get("#{controller_name}_controller".to_camel_case)
    end
    
    def controller_file_path
      File.join(self.class.controllers_path, controller_file_name)
    end
    
    def controller_file_name
      "#{controller_name}_controller.rb"
    end
    
  end
  
end