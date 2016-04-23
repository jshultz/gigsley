class CreateSchedulesTable < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.boolean :shortNotice
      t.boolean :summerMonths
      t.boolean :beforeSchool
      t.boolean :afterSchool

      t.belongs_to :profile, index: true
    end

    add_reference :profiles, :schedules, index: true
  end
end
