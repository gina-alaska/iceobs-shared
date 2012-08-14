require 'assist_shared/export/csv'
require 'assist_shared/export/json'

module AssistShared
  module Export
    def self.included(base)
      base.extend ClassMethods
    end
    
    def export_fields
      self.class.export_fields
    end
    
    module ClassMethods
      attr_accessor :export_fields
            
      def export_fields *fields 
        @export_fields = [fields].flatten unless fields.empty?
        @export_fields ||= []
      end
      

    end
        
  end
end

