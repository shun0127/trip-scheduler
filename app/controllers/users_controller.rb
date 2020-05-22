class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:show]
  def index
    @searchbar = "need"
    @users = User.order(id: :desc).page(params[:page]).per(25)
  end

  def show
    @user = User.find(params[:id])
    unless current_user == @user
      @searchbar = "need"
    end
  end

  def new
    @menubar="no_need"
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end


  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = 'ユーザ情報は正常に更新されました'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザ情報は は更新されませんでした'
      render :edit
    end
  end


  def destroy
    current_user.destroy
    flash[:success] = '退会が完了しました。'
    redirect_back(fallback_location: root_path)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :website , :information)
  end
end


