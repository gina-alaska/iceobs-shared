module AssistShared
  module Validations
    module Ship
      extend ActiveSupport::Concern
      include ActiveModel::Validations 
       
      included do
        validates :power, 
                  numericality: {
                    only_integer: true, 
                    greater_than_or_equal_to: 0, 
                    less_than_or_equal_to: 4
                  },
                  allow_blank: true
        validates :heading, 
                  numericality: {greater_than_or_equal_to: 0, less_than_or_equal_to: 360}, 
                  allow_blank: true
      end
    end
  end
end