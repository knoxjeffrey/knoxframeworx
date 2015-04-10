module Knoxframeworx
  
  class Application
    
    #eg env["PATH_INFO"] = "/pages/about". Split returns 3 elements - '', 'pages', 'about'
    #empty string assinged to dump variable, pages to controller_name and about to action
    #Object.const_get(controller_name) checks for controller_name as a constant. This will
    #not be found so similar to method missing, it will check the constant lookup path. I
    #have provided a constant missing method in dependencies to catch this in order to
    #require the file page_controller.rb in this case.
    def get_controller_and_action(env)
      _, controller_name, action = env["PATH_INFO"].split('/')
      controller_name = controller_name.capitalize + "Controller"   # = PagesController
      [Object.const_get(controller_name), action]
    end
    
  end
  
end