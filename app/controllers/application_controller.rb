class ApplicationController < ActionController::Base

  include SessionsHelper    
  private

  def require_user_logged_in
    unless logged_in?
      redirect_to root_path
    end
  end

  def counts_favorite(plan)
    @count_favorites = plan.favorites.count
  end

  
end
