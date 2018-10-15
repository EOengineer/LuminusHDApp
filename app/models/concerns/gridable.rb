module Gridable
  extend ActiveSupport::Concern

  module ClassMethods

    def to_grid
      get_grid_columns()
    end

    def grid_title
      self.to_s.pluralize
    end

    private

    def get_grid_columns
      columns      = []
      columns_hash = self.columns_hash

      columns_hash.keys.each do |attribute|
        unless %w[description created_at updated_at].include?(attribute)
          attribute_hash = { field: attribute, label: attribute.titleize, type: columns_hash[attribute].type}
          columns << attribute_hash
        end
      end

      columns
    end
  end
end