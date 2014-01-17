module AssistShared
  module CSV
    module Ship

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
      
      def self.headers
        [ 'ShP', 'ShS', 'ShH', 'ShA' ]
      end
    end
  end
end