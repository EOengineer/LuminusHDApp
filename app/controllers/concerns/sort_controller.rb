module SortController
	extend ActiveSupport::Concern

	included do 
		before_action :set_sort_variables, only: :index
	end

	private

	def set_sort_variables
		@sort_field		  = params[:sort_field] || 'id'
		@sort_direction = params[:sort_direction] || 'asc'
	end

end