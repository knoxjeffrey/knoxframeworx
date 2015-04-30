module Knoxframeworx
  
  class Controller
    
    attr_writer :status, :headers, :body
    
    def initialize(env)
      @env = env
    end
    
    def env
      @env
    end
    
    def status
      @status ||= 200
    end
    
    def headers
      @headers ||= { "Content-Type" => "text/html"}
    end
    
    def body
      @body ||= "hello"
    end
    
  end
  
end