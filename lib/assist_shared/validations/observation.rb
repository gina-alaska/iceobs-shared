module AssistShared
  module Validations
    module Observation
      extend ActiveSupport::Concern
      include ActiveModel::Validations 
      include ActiveModel::Validations
      
      included do
        validates_presence_of :primary_observer, :obs_datetime, :latitude, :longitude, :hexcode
        validates_uniqueness_of :hexcode
        
        validate :bounded
        
        def bounded
          #self.send(field) >= range.first && self.send(field) <= range.last
          true
        end
      end
    end
  end
end