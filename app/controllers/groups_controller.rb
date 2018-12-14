class GroupsController < ApplicationController
  layout 'two_column', only: [:index]

  def index
    @groups = Group.all
  end

  def create
    @group = Group.create(group_params)
    Member.create(user_id: session[:user_id], group_id: @group.id)
    flash[:notice] = @group.errors.full_messages if @group.errors.full_messages.any?
    redirect_to action: 'index'
  end

  def show
    @group = Group.find(params[:id])
    @members = Member.joins(:group).where(group_id: params[:id])
  end

  def destroy
    Group.destroy(params[:id])
    redirect_to action: 'index'
  end

  private

  def group_params
    params[:group][:user_id] = session[:user_id]
    params.require(:group).permit(:name, :description, :user_id)
  end

end
