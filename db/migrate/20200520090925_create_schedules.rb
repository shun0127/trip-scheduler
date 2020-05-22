class CreateSchedules < ActiveRecord::Migration[5.2]
  def change
    create_table :schedules do |t|
      t.references :plan, foreign_key: true
      t.date :date
      t.time :time
      t.string :destination
      t.text :content
      t.string :latitude
      t.string :longtitude
      t.string :string

      t.timestamps
    end
  end
end
