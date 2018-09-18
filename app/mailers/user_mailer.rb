class UserMailer < ApplicationMailer
	default from: 'notifications@LuminusHD.com'
 
  def welcome_email
    @user = params[:user]
    @url  = 'http://localhost:3000/login'
    mail(to: @user.email, subject: "#{@user.name}, Welcome to LuminusHD")
  end
end
