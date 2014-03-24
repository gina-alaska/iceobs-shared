module AssistShared
  module CSV
    module Observation
      extend ActiveSupport::Concern
      def as_csv opts={}
        [
          self.obs_datetime,
          first_and_last_name(self.primary_observer),
          (a = self.additional_observers.collect{|o| first_and_last_name(o)}.join(":")).present? ? a : nil,
          self.latitude,
          self.longitude,
          self.ice.as_csv,
          self.ice_observations.primary.as_csv,
          self.ice_observations.secondary.as_csv,
          self.ice_observations.tertiary.as_csv,
          self.meteorology.as_csv,
          self.ship.as_csv,
          (f = self.faunas.collect(&:name).join("//")).present? ? f : nil,
          (f = self.faunas.collect(&:count).join("//")).present? ? f : nil,
          self.photos.count,
          self.notes.collect{|n| n.text.blank? ? nil : n.text},
          self.comments.collect{|c| c.data.blank? ? nil : "#{c.data} -- #{c.user.first_and_last_name}"}
        ].flatten
      end

      def to_csv opts={}
        c = ::CSV.generate(headers: true) do |csv|
          csv << self.class.headers
          csv << self.as_csv
        end
        c
      end

      def first_and_last_name( observer )
        if observer.is_a? Hash
          o = "#{observer['firstname']} #{observer['lastname']}"
        elsif observer.is_a? String
          o = observer
        else
          o = "#{observer.firstname} #{observer.lastname}"
        end
        o
      end

      module ClassMethods
        def headers opts = {}
          comment_count = opts.delete(:comment_count) || 0
          [
            'Date',
            'PO',
            'AO',
            'LAT',
            'LON',
            Ice.headers,
            %w{ P S T }.collect{|type| IceObservation.headers prefix: type },
            Meteorology.headers,
            Ship.headers,
            'FN',
            'FC',
            'Photo',
            Array.new(3){|i| "note#{i}" },
            Array.new(comment_count){ "comment" }
          ].flatten
        end
      end
      included do
        extend ClassMethods
      end
    end
  end
end
