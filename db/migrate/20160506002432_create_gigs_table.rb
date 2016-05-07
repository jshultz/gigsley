class CreateGigsTable < ActiveRecord::Migration
  def change
    create_table :gig do |t|
      t.string :jobName
      t.string :description
      t.integer :awarded
      t.integer :job_id
      t.belongs_to :profile
      t.date :endDate
      t.timestamps null: false
    end
  end
end
