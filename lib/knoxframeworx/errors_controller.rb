class ErrorsController < Knoxframeworx::Controller
  
  def not_found
    self.status = 404
    self.body = "Page not found" 
  end
  
end