class CreatePlans < ActiveRecord::Migration[5.2]
  def change
    create_table :plans do |t|
      t.references :user, foreign_key: true
      t.string :title
      t.string :desitination
      t.text :content
      t.integer :open
      t.string :latitude
      t.string :longtitude

      t.timestamps
    end
  end
end
