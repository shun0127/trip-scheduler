class ModifyPlan < ActiveRecord::Migration[5.2]
  def change
    rename_column :plans, :desitination, :destination
  end
end
