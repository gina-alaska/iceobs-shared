module AssistShared
  module Export
    module CSV
      def self.included base
        base.extend ClassMethods
        
      end
    
      def as_csv
        row = [] 
        export_fields.each do |field|
          item = self.send(field)
          
          if item.respond_to? :as_csv
            row << item.as_csv    
          else
            row << item
          end    
        end
        row.flatten
      end
    

      module ClassMethods
        attr_accessor :csv_map
        
        def headers
          row = []
          export_fields.each do |field|
            
            begin
              if field.constantize.respond_to? :headers
                row << field.constantize.headers
              end
            rescue NameError
              row << (csv_map[field.to_sym].nil? ? field : csv_map[field.to_sym])
            end
          end
          
          row.flatten
        end
                
        def csv_map hash=nil
          @csv_map = hash unless hash.nil?
          @csv_map ||= Hash.new
        end

        def from_csv
          #Placeholder
        end

      end
      extend ClassMethods
    
    end
    
  end
end