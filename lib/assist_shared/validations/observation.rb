module AssistShared
  module Validations
    module Observation
      extend ActiveSupport::Concern
      include ActiveModel::Validations
      
      included do
        attr_accessor :finalize

        validates_presence_of :primary_observer, :obs_datetime, :latitude, :longitude, :hexcode
        validates_uniqueness_of :hexcode
        
        validate :bounded
        
        def bounded
          #self.send(field) >= range.first && self.send(field) <= range.last
          true
        end
      end
      
      def finalize?
        self.finalize.nil? ? true : self.finalize
      end
     
      def finalize!
        self.finalize = true
      end
    
      def save opts={}
        opts.merge!(validate: self.finalize?)
        super opts
      end
    
    end
  end
end