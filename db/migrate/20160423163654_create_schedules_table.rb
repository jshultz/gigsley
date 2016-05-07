class CreateSchedulesTable < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.boolean :shortNotice
      t.boolean :summerMonths
      t.boolean :beforeSchool
      t.boolean :afterSchool
      t.timestamps null: false
      t.references :profile, index: true, foreign_key: true
    end
  end
end
