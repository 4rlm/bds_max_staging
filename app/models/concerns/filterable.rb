module Filterable
  extend ActiveSupport::Concern

  module ClassMethods
    def filter(filtering_params)
      results = self.where(nil)
      filtering_params.each do |key, value|
        if value.present?
          results = results.public_send(key, value)
        end
      end
      results
    end
  end
end
