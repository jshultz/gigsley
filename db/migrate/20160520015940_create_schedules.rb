class CreateAvailability < ActiveRecord::Migration
  def change
    create_table :availability do |t|
      t.integer :start_at
      t.integer :end_at
      t.integer :day_of_week
      t.integer :gig_sched_id
      t.string :gig_sched_type

      t.timestamps null: false
    end
  end
end
