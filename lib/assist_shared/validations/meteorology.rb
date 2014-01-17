module AssistShared
  module Validations
    module Meteorology
      extend ActiveSupport::Concern
      include ActiveModel::Validations 
      
      included do
        validates_with ::AssistShared::Validations::LookupCodeValidator, 
                        fields: {visibility_lookup_id: 'visibility_lookup', weather_lookup_id: 'weather_lookup'}, 
                        allow_blank: true
                        #Visibility should be required
        
        validates :total_cloud_cover, :numericality, 
          {only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 8}, allow_blank: true
        validates :wind_speed, :numericality,
          {greater_than_or_equal_to: 0}, allow_blank: true
        validates :wind_direction, :numericality,
          {greater_than_or_equal_to: 0, less_than_or_equal_to: 360}, allow_blank: true
        validates :air_temperature, :numericality
        validates :water_temperature, :numericality
        validates :relative_humidity, :numericality,
          {greater_than_or_equal_to: 0, less_than_or_equal_to: 100}, allow_blank: true
        validates :relative_humidity, :numericality
        # validates :cloud_heights, clouds.high, clouds.medium, ">"
        # 
        # def cloud_heights a, b, comparison
        #   valid = true
        #   unless a.cloud_height.nil? || b.cloud_height.nil?
        #     valid = a.send(b, comparison)
        #   end
        #   valid
        # end
        
        # def cloud_heights
        #   unless clouds.high.cloud_height.nil?
        #     if clouds.high.cloud_height < clouds.medium.cloud_height
        #       clouds.high.errors.add :cloud_height, "should be above the medium cloud height"
        #     end
        #     
        #     if clouds.high.cloud_height < clouds.low.cloud_height
        #       clouds.high.errors.add :cloud_height, "should be above the low cloud height"
        #     end
        #   end
        #   
        # end
      end
    end
  end
end