module TableController
	extend ActiveSupport::Concern

	included do 
		before_action :set_resource_name, only: :index
		before_action :set_resource, only: :index
		before_action :set_columns, only: :index
	end

	private

	def set_resource_name
		@resource_name = controller_name.classify.titleize
	end

	def set_resource
		@resource 	 = controller_name.classify.constantize.all
	end

	def set_columns
		@columns 		 = []
		columns_hash = controller_name.classify.constantize.columns_hash

		columns_hash.keys.each do |attribute|
			unless %w[description created_at updated_at].include?(attribute)
				attribute_hash = { field: attribute, label: attribute.titleize, type: columns_hash[attribute].type}
				@columns << attribute_hash
			end
		end


	end

end