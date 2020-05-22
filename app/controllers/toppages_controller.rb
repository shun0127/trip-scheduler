class ToppagesController < ApplicationController
  def index
    @menubar ="no_need"
    if logged_in?
      @menubar="need"
      @plans = current_user.plans.order(id: :desc).page(params[:page])
    end
  end
end
