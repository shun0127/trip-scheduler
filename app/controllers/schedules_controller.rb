class SchedulesController < ApplicationController
  def show
  end

  def edit
  end

  def update
  end

  def create
  end

  def destroy
    @schedule.destroy
      flash[:success] = 'スケジュールを削除しました。'
    redirect_back(fallback_location: root_path)
  end

  def new
  end
end
