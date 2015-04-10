class Object
  #controllers sent as a constant are caught in this method.
  #eg. the constant PagesController will become:
  #require pages_controller
  #this is a way of autoloading my controller files and then returning the controller class again
  def self.const_missing(const)
    begin
      require const.to_s.to_snake_case
      Object.const_get(const)
    rescue LoadError
      return 
    end 
  end
  
end