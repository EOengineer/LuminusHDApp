class Admin::DashboardsController < Admin::BaseController
	

	def index		
		add_breadcrumb "Dashboard", :admin_dashboards
	end


end