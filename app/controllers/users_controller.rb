class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(name: params[:user][:name], email: params[:user][:email])
    if @user.save
      flash[:success] = "Register success"
      # UserMailer.welcome_email.deliver_now @user
      SendEmailJob.set(wait: 1.minutes).perform_later @user
      redirect_to new_user_path
    else
      flash[:danger] = "Register fail"
      render :new
    end
  end
end
