module AssistShared
  module CSV
    module Fauna
      def as_csv opts={}
        [
          name,
          count
        ]
      end

      def self.headers opts={}
        ['FT', 'FC'].collect{|i| "#{opts[:prefix]}#{i}#{opts[:suffix]}"}
      end

    end
  end
end