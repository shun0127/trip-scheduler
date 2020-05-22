class PlansController < ApplicationController
  def index
    @plans = current_user.plans.order(id: :desc).page(params[:page]).per(25)
  end

  def show
    @plan = Plan.find(params[:id])
    @schedules = @plan.schedules
  end

  def new
    @plan = Plan.new
    @schedule = @plan.schedules.build
  end

  def create
#    binding.pry
    @plan = current_user.plans.build(plan_params)
    if @plan.save
      redirect_to @plan
    else
      flash.now[:danger] = '全項目入力してください。'
      render :new
    end
  end
 
  def edit
    @plan = Plan.find(params[:id])
  end
  
  def update
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



  def destroy
    #binding.pry
    @plan = Plan.find(params[:id])
    @plan.destroy
    flash[:success] = '旅行プランを削除しました。'
    redirect_to plans_path
  end


  def search
    @searchbar = "need"
    @plans = Plan.all.order(id: :desc).page(params[:page]).per(25)
  end  
 
 
  def plan_ranking
    @searchbar = "need"
    @plans = Plan.all.order(id: :desc).page(params[:page]).per(25)
  end   

  private
  
  def plan_params
    params.require(:plan).permit(:title,:content,:destination,schedules_attributes: [:id, :date, :time, :destination, :content, :_destroy])
  end

  def plam_only_params
    params.require(:user).permit(:title,:content,:destination)
  end
end
