require "knoxframeworx/version"

module Knoxframeworx
  
  class Application 
    def call(env)
      [ 200, { "Content-Type" => "text/html" }, ["I'm Alive!"] ]
    end
  end
  
end
