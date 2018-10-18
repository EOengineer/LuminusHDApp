module Sortable
  extend ActiveSupport::Concern

  module ClassMethods
    def sorted(column, direction = nil)
      column    = sort_column(column)
      direction = sort_direction(direction)

      order("#{column} #{direction}")
    end

    private

    # used to prepend table name to sort column
    # neccessary to avoid ambiguous column names errors in cases where sorting via an association attribute 
    def table_prefix(column)
      self.has_attribute?(column) ? self.table_name : column.tableize
    end

    def sortable_columns
      self.column_names
    end

    def sort_column(column)
      table = table_prefix(column)
      sortable_columns.include?(column) ? "#{table}.#{column}" : "#{table}.#{default_column}"
    end

    def sort_direction(direction)
      %w[asc desc].include?(direction) ? direction : "asc"
    end

    def default_column
      self.has_attribute?(:title) ? "title" : "name"
    end

  end
end