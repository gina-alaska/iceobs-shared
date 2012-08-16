module AssistShared
  module CSV
    module IceObservation
      def as_csv opts={}
        [
          self.partial_concentration,
          self.ice_lookup_code,
          self.thickness,
          self.floe_size_lookup_code,
          self.snow_lookup_code,
          self.snow_thickness,
          self.topography.as_csv,
          self.melt_pond.as_csv,
          self.biota_lookup_code,
          self.sediment_lookup_code
        ]
      end

      def self.headers opts={}
        [
          'PC',
          'T',
          'Z',
          'F',
          'SY',
          'SH',
          Topography.headers,
          MeltPond.headers,
          'A',
          'SD'        
        ].flatten.collect{|i| "#{opts[:prefix]}#{i}#{opts[:suffix]}"}
      end

    end
  end
end