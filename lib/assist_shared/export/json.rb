module AssistShared
  module Export
    module JSON
      
      def self.included base
        base.extend ClassMethods
      end
      
      def as_json
        row = Hash.new 
        export_fields.each do |field|
          if self.reflections.keys.include? field.to_sym
            row[field] = self.send(field.as_json)
          else
            row[field] = self.send(field)
          end
        end
        row
      end


      module ClassMethods
        def from_json
          #Placeholder
        end

      end
      extend ClassMethods

    end

  end
end