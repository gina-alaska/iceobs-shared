module AssistShared
  module Validations
    module Topography
      extend ActiveSupport::Concern
       
      included do
        validates :concentration, numericality: {only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 10}, allow_blank: true
        validates :ridge_height, numericality: {greater_than_or_equal_to: 0}, allow_blank: true
        
        validates_with ::AssistShared::Validations::LookupCodeValidator, fields: {topography_lookup: 'topography_lookup'}, allow_blank: true
      end
    end
  end
end