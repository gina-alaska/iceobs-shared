module AssistShared
  module Validations
    module Observation
      extend ActiveSupport::Concern
      include ActiveModel::Validations
      
      included do
        attr_accessor :finalize

        validates_presence_of :primary_observer, :obs_datetime, :latitude, :longitude, :hexcode
        validates_uniqueness_of :hexcode, message: "This cruise already exists (Lat/Lon, Time)"
        
        validate :location
        validate :partial_concentrations_equal_total_concentration
        validate :partial_concentrations_are_descending_order
        validate :ice_thickness
        validate :ice_thickness_are_decreasing_order
        validate :ice_lookup_codes
        validate :ice_lookup_codes_are_increasing_order
        
        def location 
          errors.add(:latitude, "Latitude must be between -90 and 90") unless (latitude.to_f <= 90 && latitude.to_f >= -90)
          errors.add(:longitude, "Longitude must be between -180 and 180") unless (longitude.to_f <= 180 && longitude.to_f >= -180)
        end
        
        def partial_concentrations_equal_total_concentration
          partial_concentration = ice_observations.inject(0){|sum,p| sum + p.partial_concentration.to_i}
          primary = ice_observations.primary
          secondary = ice_observations.secondary
          tertiary = ice_observations.tertiary
          
          if partial_concentration != 0 and ice.total_concentration != partial_concentration
            errors.add(:ice, "Partial concentrations must equal total concentration")
            primary.errors.add(:partial_concentration)
            secondary.errors.add(:partial_concentration)
            tertiary.errors.add(:partial_concentration)
          end
        end

        def partial_concentrations_are_descending_order
          primary = ice_observations.primary
          secondary = ice_observations.secondary
          tertiary = ice_observations.tertiary
          
          if secondary.partial_concentration and secondary.partial_concentration > primary.partial_concentration.to_i
            secondary.errors.add(:partial_concentration)
            errors.add(:ice, "Secondary partial concentration greater than primary")
          end
          if tertiary.partial_concentration and tertiary.partial_concentration > secondary.partial_concentration.to_i
            tertiary.errors.add(:partial_concentration)
            errors.add(:ice, "Tertiary partial concentration greater than secondary")
          end
        end
        
        def ice_thickness
          primary = ice_observations.primary
          secondary = ice_observations.secondary
          tertiary = ice_observations.tertiary

          if secondary.thickness and !primary.thickness
            secondary.errors.add(:thickness)
            errors.add(:ice, "Secondary thickness without primary thickness") 
          end
          if tertiary.thickness and !secondary.thickness
            tertiary.errors.add(:thickness)
            errors.add(:ice, "Tertiary thickness without secondary thickness") 
          end
        end
        
        def ice_thickness_are_decreasing_order
          primary = ice_observations.primary
          secondary = ice_observations.secondary
          tertiary = ice_observations.tertiary
          
          if primary.thickness and primary.thickness <= secondary.thickness.to_i
            secondary.errors.add(:thickness)
            errors.add(:ice, "Primary thickness must be greater than secondary thickness")
          end
          if secondary.thickness and secondary.thickness <= tertiary.thickness.to_i
            tertiary.errors.add(:thickness)
            errors.add(:ice, "Secondary thickness must be greater than tertiary thickness")
          end
        end
        
        def ice_lookup_codes_are_increasing_order
          primary = ice_observations.primary
          secondary = ice_observations.secondary
          tertiary = ice_observations.tertiary
          
          if (ice.thick_ice_lookup and primary.ice_lookup) and (ice.thick_ice_lookup.code < primary.ice_lookup.code)
            errors.add(:ice, "Thick ice type thinner than primary")
            primary.errors.add(:ice_lookup_id)
          end
          if (primary.ice_lookup and secondary.ice_lookup) and (primary.ice_lookup.code < secondary.ice_lookup.code)
            errors.add(:ice, "Primary ice type thinner than secondary")
            secondary.errors.add(:ice_lookup_id)
          end
          if (secondary.ice_lookup and tertiary.ice_lookup) and (secondary.ice_lookup.code < tertiary.ice_lookup.code)
            errors.add(:ice, "Secondary ice type thinner than tertiary")
            tertiary.errors.add(:ice_lookup_id)
          end
          if (ice.thin_ice_lookup and tertiary.ice_lookup) and (tertiary.ice_lookup.code < ice.thin_ice_lookup.code)
            errors.add(:ice, "Tertiary ice type thinner than thin ice type")
            tertiary.errors.add(:ice_lookup_id)
          end

        end
        
        def ice_lookup_codes
          primary = ice_observations.primary
          secondary = ice_observations.secondary
          tertiary = ice_observations.tertiary
          
          if (secondary.ice_lookup and !primary.ice_lookup)
            errors.add(:ice, "Secondary ice type without primary")
            secondary.errors.add(:ice_lookup_id)
          end
          if (tertiary.ice_lookup and !secondary.ice_lookup)
            errors.add(:ice, "Tertiary ice type without primary")
            tertiary.errors.add(:ice_lookup_id)
          end
        end
      end
      
      def finalize?
        self.finalize.nil? ? true : self.finalize
      end
    
      def save opts={}
        opts.merge!(validate: self.finalize?)
        super opts
      end
    
    end
  end
end
