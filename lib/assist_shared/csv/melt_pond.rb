module AssistShared
  module CSV
    module MeltPond
      def as_csv opts={}
        [
          self.surface_coverage,
          self.max_depth_lookup.try(:code),
          self.pattern_lookup.try(:code),
          self.surface_lookup.try(:code),
          self.freeboard,
          self.bottom_type_lookup.try(:code)
        ]
      end

      def self.headers opts={}
        [ 'MPC', 'MPD', 'MPP', 'MPT', 'MPF', 'MBT']
      end

    end
  end
end