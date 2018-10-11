class UsersController < BaseController
	skip_before_action :authorize, only: [:new, :create]
  before_action :restrict_access, only: [:edit, :update]

	layout "public_login"

	def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    # store all emails in lowercase to avoid duplicates and case-sensitive login errors:
    @user.email.downcase!
    
    if @user.save
    	UserMailer.with(user: @user).welcome_email.deliver_later
      session[:user_id] = @user.id
      flash[:notice] = "Account created successfully!"
      redirect_to root_path
    else
      flash.now.alert = "Oops, couldn't create account. Please make sure you are using a valid email and password and try again."
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to edit_user_path(@user)
      flash[:notice] = "Account updated successfully!"
    else
      render :edit
      flash.now.alert = "Oops, couldn't update account. Please verify your data is correct."
    end
  end

private

  def restrict_access
    redirect_to root_path unless current_user.id == params[:id].to_i
  end

  def user_params
    # strong parameters - whitelist of allowed fields #=> permit(:name, :email, ...)
    # that can be submitted by a form to the user model #=> require(:user)
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :avatar)
  end
end
