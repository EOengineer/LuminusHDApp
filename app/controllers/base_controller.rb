class BaseController < ApplicationController
	# layout "admin"
  before_action :authorize

  # add_breadcrumb "Home", :admin_root

  def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  private
  
  def authorize
      redirect_to new_session_path unless current_user
  end	
end