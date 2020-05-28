class FavoritesController < ApplicationController
  before_action :require_user_logged_in
  def create
    add_plan = Plan.find(params[:plan_id])
    add_user = User.find(add_plan.user_id)
    current_user.add_favorite(add_plan)
#binding.pry
    flash[:success] = "お気に入りに追加しました。"
    if params[:call_favorite_from] == "show"
      redirect_to add_plan
    elsif params[:call_favorite_from] == "from_index"
      redirect_to root_url
    else
      redirect_to root_url
    end
  end

  def destroy
    rm_plan = Plan.find(params[:plan_id])
    plan_user = User.find(rm_plan.user_id)
    current_user.rm_favorite(rm_plan)
    flash[:success]="お気に入りから削除しました。"
#binding.pry
    if params[:call_favorite_from] == "show"
      redirect_to rm_plan
    elsif params[:call_favorite_from] == "from_favorites_list"
      redirect_to likes_user_path(current_user)
    elsif params[:call_favorite_from] == "from_index"
      redirect_to root_url
    else
      redirect_to root_url
    end
  end
end
