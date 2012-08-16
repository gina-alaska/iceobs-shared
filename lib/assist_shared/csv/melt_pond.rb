module AssistShared
  module CSV
    module MeltPond
      def as_csv opts={}
        [
          self.surface_coverage,
          self.max_depth_lookup_code,
          self.pattern_lookup_code,
          self.surface_lookup_code,
          self.freeboard
        ]
      end

      def self.headers opts={}
        [ 'MPC', 'MPD', 'MPP', 'MPT', 'F']
      end

    end
  end
end