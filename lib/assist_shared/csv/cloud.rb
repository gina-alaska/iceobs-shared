module AssistShared
  module CSV
    module Cloud
      def as_csv opts={}
        [
          self.cloud_lookup_code,
          self.height,
          self.cover
        ]
      end

      def self.headers opts={}
        ['Y', 'V', 'H'].collect{|i| "#{opts[:prefix]}#{i}#{opts[:suffix]}"}
      end

    end
  end
end