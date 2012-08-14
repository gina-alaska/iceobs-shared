module AssistShared
  module Validations
    class LookupCodeValidator < ActiveModel::Validator
      def validate(record)
        if options[:fields].any?
          options[:fields].each do |field, table|
            klass = table.camelcase.constantize
            attribute = record.attributes.keys.select{|a| a.start_with? field.to_s}.first
            unless options[:allow_blank] && record.send(attribute).nil?
              unless klass.where(code: record.send(attribute)).any?
                record.errors.add attribute, "contains an invalid lookup code"
              end
            end
          end
        end
      end
    end
  end
end