class UsersController < ApplicationController

  def create
    @user = User.create(user_params)
    if @user.errors.full_messages.any?
      flash[:signup_errors] = @user.errors.full_messages
      redirect_to controller: 'sessions', action: 'index'
    else
      # flash[:notice]    = ['User successfully created']
      # flash[:notice]    = ["Welcome, #{@user.name}"]
      session[:user_id] = @user.id
      redirect_to controller: 'groups', action: 'index'
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
