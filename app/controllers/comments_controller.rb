class CommentsController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    @comment = Comment.new(comment_params)
#binding.pry
    @plan=Plan.find(comment_params[:plan_id])

    if @comment.save
      flash[:success] = "コメントを登録しました。"
      redirect_to @plan
    else
      @user= User.find(@plan.user_id)
      @comments = @user.comments.where(plan_id: @plan.id)
      @schedules = @plan.schedules
      flash.now[:danger] = 'コメントの登録に失敗しました。'
      render "plans/show"
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @plan=Plan.find(@comment.plan_id)
    @comment.destroy
    flash[:success] = 'コメントを削除しました。'
    redirect_to @plan
  end
  
  def comment_params
    params.require(:comment).permit(:user_id,:plan_id,:comment)
  end
end
