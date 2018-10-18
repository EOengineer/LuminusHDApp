module PaginationController
	extend ActiveSupport::Concern

	included do 
		before_action :set_pagination_variables, only: :index
	end

	private

	def set_pagination_variables
		@current_page = params[:current_page].try(:to_i) || 1
		@per_page 		= params[:per_page].try(:to_i) || 10
		@total_count 	= @resource.count
		@pages 				= (@total_count.fdiv(@per_page)).floor 
	end

end