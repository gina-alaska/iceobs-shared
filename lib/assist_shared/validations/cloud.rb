module AssistShared
  module Validations
    module Cloud
      extend ActiveSupport::Concern
      include ActiveModel::Validations 
       
      included do
        validates :cover, numericality: {greater_than_or_equal_to: 0}, allow_blank: true
        validates :height, numericality: {only_integer: true, greater_than_or_equal_to: 0} , allow_blank: true
        validates :cloud_type, inclusion: {in: %w(low medium high)}
      end
    end
  end
end