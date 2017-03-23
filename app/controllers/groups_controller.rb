class GroupsController < ApplicationController
  before_action :authenticate_user! , only: [:new,:create,:edit,:update,:destroy]
  before_action :find_group_and_checkout_permission, only: [:edit, :update, :destroy]
  def index
    @groups =Group.all
  end

  def new
    @group=Group.new
  end

  def show
    @group=Group.find(params[:id])
    @reviews= @group.reviews.recent.paginate(:page => params[:page], :per_page => 6)
  end

  def edit

  end

  def create
    @group=Group.new(group_params)
    @group.user =current_user

    if @group.save
      current_user.join!(@group)
      redirect_to groups_path
    else
      render :new
    end
  end

  def update


    if @group.update(group_params)
      redirect_to groups_path, notice: "Update Success"
    else
      render :edit
    end
  end

  def destroy

    @group.destroy
    redirect_to groups_path, alert: "Movive delete"
  end


  def join
   @group = Group.find(params[:id])

    if !current_user.is_member_of?(@group)
      current_user.join!(@group)
      flash[:notice] = "收藏成功！"
    else
      flash[:warning] = "已收藏了！"
    end

    redirect_to group_path(@group)
  end

  def quit
    @group = Group.find(params[:id])

    if current_user.is_member_of?(@group)
      current_user.quit!(@group)
      flash[:alert] = "收藏已删除！"
    else
      flash[:warning] = "未收藏，无法删除"
    end

    redirect_to group_path(@group)
  end


  private

  def find_group_and_checkout_permission
    @group =Group.find(params[:id])
    if current_user != @group.user
      redirect_to root_path , alert: "you have no permission"
    end
  end

  def group_params
    params.require(:group).permit(:title,:description)
  end


end
