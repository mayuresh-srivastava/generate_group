class GroupsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_group, only: [:invite, :invitation_response]

  def index
    @groups = Group.all.order(created_at: :desc)
    @group = Group.new
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params.merge(status: 'initiated'))

    respond_to do |format|
      if @group.save
        format.html { redirect_to groups_path, notice: t('new_group_request') }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  def invite
  end

  def invitation_response
    if @group.gathering_date > Date.current
      UserGroup.create(group: @group, user: current_user, response: params[:user_group][:response])
      redirect_to root_path, notice: t('thanks')
    else
      redirect_to root_path, notice: t('sorry')
    end
  end

  private

  def group_params
    params.require(:group).permit(:name, :description, :gathering_date)
  end

  def set_group
    @group = Group.find(params[:id])
  end
end
