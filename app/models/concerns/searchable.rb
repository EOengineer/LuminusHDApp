module Searchable
  extend ActiveSupport::Concern

  module ClassMethods
    attr_reader :searchable_attributes

    def search_columns(term)
      if term.present? 
        where(concatonated_query, "%#{term}%")
      else
        where(nil)
      end

    end


    private

    def search_attributes(includes: [])
      @searchable_attributes = includes
    end

    def query_start
      "concat_ws(' ', "
    end

    def query_end
      ") ILIKE ?"
    end

    def attribute_list
      @searchable_attributes.join(", ")
    end

    def concatonated_query
      query_start +
      attribute_list +
      query_end
    end

  end
end