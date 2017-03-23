class ReviewsController < ApplicationController
  before_action :authenticate_user!, :only => [:new,:create]
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
    @group =Group.find(params[:group_id])
    @review =Review.find(params[:id])
  end

  def update
    @group =Group.find(params[:group_id])
    @review =Review.find(params[:id])

    if @review.update(review_params)
      redirect_to account_reviews_path ,notice: "update success"
    else
      render :edit
    end
  end

  def destroy
    @group =Group.find(params[:group_id])
    @review =Review.find(params[:id])
    @review.destroy

    redirect_to account_reviews_path, alert: "review deleted"
  end


  private

  def review_params
    params.require(:review).permit(:content)
  end

end
