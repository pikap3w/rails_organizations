class SessionsController < ApplicationController
  layout 'two_column', only: [:index]
  # Render login page
  def index; end

  def create
    user = User.find_by_email(params[:email]).try(:authenticate, params[:password])
    if user # if authenticate == true:
      # save user id to session
      session[:user_id] = user.id
      # redirect to users profile page
      redirect_to controller: 'groups', action: 'index'
    else # if authenticate == false:
      # add an error message -> flash[:errors] = ["Invalid"]
      flash[:login_errors] = ['Invalid Combination']
      # redirect to login page
      redirect_to action: 'index'
    end
  end

  # Log User out
  def destroy
    # set session[:user_id] to null
    session[:user_id] = nil
    reset_session
    # redirect to login page
    redirect_to action: 'index'
  end
end
