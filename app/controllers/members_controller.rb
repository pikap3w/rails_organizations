class MembersController < ApplicationController

  def create
    Member.create(user_id: session[:user_id], group_id: params[:group][:group_id])
    redirect_to groups_url
  end

  def destroy
    @member = Member.find(params[:id])
    @member.destroy unless session[:user_id] != @member.user_id
    redirect_to groups_url
  end
end
