module AssistShared
  module CSV
    module Meteorology
      def as_csv opts={}
        [
          self.weather_lookup.try(:code),
          self.visibility_lookup.try(:code),
          self.clouds.high.as_csv,
          self.clouds.medium.as_csv,
          self.clouds.low.as_csv,
          self.total_cloud_cover,
          self.wind_speed,
          self.air_temperature,
          self.water_temperature,
          self.relative_humidity,
          self.air_pressure
        ]
      end
      
      def self.headers opts={}
        [
          'WX',
          'V',
          %W{ H M L }.collect{|type| Cloud.headers prefix: type} ,
          'TCC',
          'WS',
          'AT',
          'WT',
          'RelH',
          'AP'       
        ].flatten
      end
      
    end
  end
end
