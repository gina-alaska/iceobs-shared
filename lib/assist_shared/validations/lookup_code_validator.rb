module AssistShared
  module Validations
    class LookupCodeValidator < ActiveModel::Validator
      def validate(record)
        if options[:fields].any?
          options[:fields].each do |field, table|
            klass = table.camelcase.constantize
            puts "Looking for #{klass}"
            puts "Should I check this record? #{options[:allow_blank]} && #{record.send(field).nil?}"
            puts "record.send(#{field})"
            unless options[:allow_blank] && record.send(field).nil?
              puts "Looking at #{klass}.where(id: #{record}.send(#{field}))"
              unless klass.where(id: record.send(field)).any?
                record.errors.add field, "contains an invalid lookup code"
              end
            end
          end
        end
      end
    end
  end
end