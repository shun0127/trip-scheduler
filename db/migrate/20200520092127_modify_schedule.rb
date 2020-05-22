class ModifySchedule < ActiveRecord::Migration[5.2]
  def change
    remove_column :schedules, :string, :string 
  end
end
