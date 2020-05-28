class PlansController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:edit,:update, :destroy]
  def index
    @plans = current_user.plans.order(id: :desc).page(params[:page]).per(25)
  end

  def show
    @plan = Plan.find(params[:id])
    @user= User.find(@plan.user_id)
    @comments = @user.comments.where(plan_id: @plan.id)
    @schedules = @plan.schedules
  end

  def new
    @plan = Plan.new
    @schedule = @plan.schedules.build
  end
  
  def reuse
    @plan = Plan.find(params[:format])
  end
  
  

  def create
    @plan = current_user.plans.build(plan_params)
    if @plan.save
      redirect_to @plan
              flash[:success] = '旅行プランは正常に更新されました'
    else
      flash.now[:danger] = '全項目入力してください。'
      render :new
    end
  end
 
  def edit
    @plan = Plan.find(params[:id])
 
  end
  
  def update
#binding.pry
    if params[:reuse] == "reuse"
      @plan = current_user.plans.build(plan_reuse_params)
      if @plan.save
        redirect_to @plan
      else
        flash.now[:danger] = '全項目入力してください。'
        render :new
      end
    else
      @plan = Plan.find(params[:id])
      @schedules = @plan.schedules
      #binding.pry     
      if @plan.update(plan_params)
        flash[:success] = '旅行プランは正常に更新されました'
        redirect_to @plan
      else
        flash.now[:danger] = '旅行プランは更新されませんでした'
        render :edit
      end
    end
  end



  def destroy
    #binding.pry
    @plan = Plan.find(params[:id])
    @plan.destroy
    flash[:success] = '旅行プランを削除しました。'
    redirect_to plans_path
  end


  def search
    @searchbar = "need"
    @plans = Plan.where(open: 1 ).where('destination LIKE ?', "%#{params[:destination]}%").order(id: :desc).page(params[:page]).per(25)
    #binding.pry
  end  
 
 
  def plan_ranking
    @searchbar = "need"
    #binding.pry
    @plans = Plan.joins("left join favorites on plans.id = favorites.plan_id").group("plans.id").order("count(favorites.id) desc").page(params[:page]).per(25)
  end   



  private
  
  def plan_params
    params.require(:plan).permit(:title,:content,:destination,:open,schedules_attributes: [:id, :date, :time, :destination, :content, :_destroy])
  end
  def plan_reuse_params
    params.require(:plan).permit(:title,:content,:destination,:open,schedules_attributes: [ :date, :time, :destination, :content, :_destroy])
  end
  def correct_user
    unless params[:reuse] == "reuse"
      @plan = current_user.plans.find_by(id: params[:id])
      unless @plan
          redirect_to root_url
      end
    end
  end
end
