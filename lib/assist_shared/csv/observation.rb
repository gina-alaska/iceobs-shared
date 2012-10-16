module AssistShared
  module CSV
    module Observation
      extend ActiveSupport::Concern
      def as_csv opts={}
        [ 
          self.obs_datetime,
          self.primary_observer,
          self.additional_observers.join(":"),
          self.latitude,
          self.longitude,
          self.ice.as_csv,
          self.meteorology.as_csv,
          self.ice_observations.primary.as_csv, 
          self.ice_observations.secondary.as_csv, 
          self.ice_observations.tertiary.as_csv
        ].flatten
      end
      
      def to_csv opts={}
        c = ::CSV.generate(headers: true) do |csv|
          csv << self.class.headers
          csv << self.as_csv
        end
        c
      end
      
      module ClassMethods
        def headers opts = {}
          [
            'Date',
            'PO',
            'AO',
            'LAT',
            'LON',
            Ice.headers,
            Meteorology.headers,
            %w{ P S T }.collect{|type| IceObservation.headers prefix: type }
          ].flatten
        end
      end
      included do
        extend ClassMethods
      end
    end
  end
end
      