module GridController
	extend ActiveSupport::Concern

	included do 
		before_action :set_resource_name, only: :index
		before_action :set_resource, only: :index
		before_action :set_grid_columns, only: :index
	end

	private

	def set_resource
		@resource = controller_name.classify.constantize.all
	end

	# calls classmethod defined in gridable.rb
	def set_resource_name
		@resource_name = controller_name.classify.constantize.grid_title
	end

	# calls classmethod defined in gridable.rb
	def set_grid_columns
		@columns = controller_name.classify.constantize.to_grid
	end

end