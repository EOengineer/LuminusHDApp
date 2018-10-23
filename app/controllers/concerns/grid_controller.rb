module GridController
	extend ActiveSupport::Concern
	
  include SortController
  include PaginationController

	included do 
		before_action :set_resource_name, only: :index
		before_action :set_resource, only: :index
		before_action :set_grid_columns, only: :index

		def index
	    @query = @resource.left_joins(associated_tables)
	              .search_columns(params[:q])
	              .sorted(@sort_field, @sort_direction)

	    @total_count  = @query.count
	    @pages        = (@total_count.fdiv(@per_page)).floor 
	    @query        = @query.paginated(@current_page, @per_page)

	    add_breadcrumb @resource_name, "admin_#{@resource_name.downcase}".to_sym
	  end
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

	def associated_tables
		controller_name.classify.constantize.reflect_on_all_associations(:belongs_to).map(&:name)
	end

end