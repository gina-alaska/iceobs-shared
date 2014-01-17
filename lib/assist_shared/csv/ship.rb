module AssistShared
  module CSV
    module Ship
      extend ActiveSupport::Concern

      def as_csv opts={}
        [
          self.power,
          self.speed,
          self.heading,
          self.ship_activity_lookup.try(:code)
        ]
      end
      
      def to_csv opts={}
        c = ::CSV.generate(headers: true) do |csv|
          csv << self.class.headers
          csv << self.as_csv
        end
        c
      end
      
      module ClassMethods
        def headers
          [ 'ShP', 'ShS', 'ShH', 'ShA' ]
        end
      end
      included do
        extend ClassMethods
      end
    end
  end
end