module Knoxframeworx
  
  class Router
    
    class ParsedPath 
      
      attr_accessor :section_1, :section_2, :section_3
      
      def initialize(section_1, section_2, section_3)
        @section_1 = section_1
        @section_2 = section_2
        @section_3 = section_3
      end
      
      def is_root?
        !section_1 and !section_2 and !section_3
      end
      
      def is_index?
        section_1 and !section_2 and !section_3
      end
      
      def is_collection_index?
        section_1 and !section_2 and section_3
      end
      
      def is_implicit_member?
        section_1 and section_2 and !section_3
      end
      
      def is_invalid?
        [section_1, section_3].compact.detect { |segement| segement !~ /[a-z_-]/i }
      end
      
    end
    
    def self.controller_and_action_for_path(path, method = :GET)
      method        = method.to_sym
      parsed_path   = parse_path_as_sections(path)
      
      case 
      when parsed_path.is_invalid? then [:error, :not_found]
        
      when parsed_path.is_root?  then [:home, :index]        
        
      when parsed_path.is_collection_index? 
        then controller_and_action_for_resource_collection(parsed_path)
        
      when parsed_path.is_index?
        then controller_and_action_for_index(parsed_path, method)
        
      # e.g. users/1
      # ... an EXPLICIT member would be: users/1/edit, which is handled below
      when parsed_path.is_implicit_member?
        then controller_and_action_for_implicit_member(parsed_path, method)
        
      else
        [parsed_path.section_1, parsed_path.section_3].map(&:to_sym)
      end
    end


    private
    
    
    IMPLICIT_ACTIONS_FOR_METHODS = {
      :PATCH => :update,
      :DELETE => :destroy
    }
    
    
    def self.controller_and_action_for_implicit_member(parsed_path, method)
      action_name = IMPLICIT_ACTIONS_FOR_METHODS[method] || :show
      [parsed_path.section_1.to_sym, action_name]
    end
    
    INDEX_ACTIONS_FOR_METHODS = {
      :POST => :create,
    }
    
    def self.controller_and_action_for_index(parsed_path, method)
      action_name = INDEX_ACTIONS_FOR_METHODS[method] || :index
      [parsed_path.section_1, action_name].map(&:to_sym)
    end
    
    def self.controller_and_action_for_resource_collection(parsed_path)
      [parsed_path.section_1, parsed_path.section_3].map(&:to_sym)
    end
    
    def self.parse_path_as_sections(path)
      args = path.scan(/\/?([^\/]+)?\/?(\d+)?\/?([^\/]+)?/).first
      ParsedPath.new(*args)
    end
    
  end
  
end