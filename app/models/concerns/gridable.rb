module Gridable
  extend ActiveSupport::Concern

  module ClassMethods
    attr_reader :gridable_attributes

    def to_grid
      get_grid_columns()
    end

    def grid_title
      self.to_s.pluralize
    end

    private

    def grid_attributes(includes: [])
      @gridable_attributes = includes
    end

    def get_grid_columns
      columns      = []
      columns_hash = self.columns_hash
      associations = get_associations


      @gridable_attributes.each do |whitelisted_attribute|

          associated = associations.include?(whitelisted_attribute)

          attribute_hash = { 
            field: whitelisted_attribute, 
            label: whitelisted_attribute.titleize, 
            type: associated ? columns_hash["#{whitelisted_attribute}_id"].type : columns_hash[whitelisted_attribute].type, 
            association: associated, 
            association_attr: associated ? association_attribute(whitelisted_attribute) : nil 
          }

          columns << attribute_hash
      end

      columns
    end

    def get_associations
      self.reflect_on_all_associations(:belongs_to).map { |association| association.name.to_s }
    end

    def association_attribute(klass)
      klass.classify.try(:constantize).try(:has_attribute?, 'title') ? 'title' : 'name'
    end
  end
end