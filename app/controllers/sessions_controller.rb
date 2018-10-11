class SessionsController < BaseController
  skip_before_action :authorize, only: [:new, :create]
  layout "public_login"

  def new
  end

  def create
    user = User.find_by(email: params[:login][:email].downcase)
    
    if user && user.authenticate(params[:login][:password]) 
      session[:user_id] = user.id.to_s
      redirect_to root_path, notice: 'Successfully logged in!'
    else
      flash.now.alert = "Incorrect email or password, try again."
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to login_path, notice: "Logged out!"
  end
end