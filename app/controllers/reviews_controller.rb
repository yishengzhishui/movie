class ReviewsController < ApplicationController
  before_action :authenticate_user!, :only => [:new,:create,:edit,:update,:destroy]
  before_action :find_review_and_check_permission, only: [:edit, :update, :destroy]
  def new
    @group =Group.find(params[:group_id])
    @review =Review.new
  end

  def create
    @group = Group.find(params[:group_id])
    @review = Review.new(review_params)
    @review.group = @group
    @review.user = current_user

    if @review.save
      redirect_to group_path(@group)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @review.update(review_params)
      redirect_to account_reviews_path ,notice: "update success"
    else
      render :edit
    end
  end

  def destroy

    @review.destroy

    redirect_to account_reviews_path, alert: "review deleted"
  end


  private

  def find_review_and_check_permission
    @group = Group.find(params[:group_id])
    @review =Review.find(params[:id])

    if current_user != @review.user
      redirect_to root_path, alert: "You have no permission"
    end
  end


  def review_params
    params.require(:review).permit(:content)
  end

end
