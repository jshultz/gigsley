class CreateHiringTable < ActiveRecord::Migration
  def change
    create_table :hiring do |t|
      t.string :jobName
      t.string :description
      t.integer :awarded
      t.integer :job_id
      t.references :profile, index: true, foreign_key: true
    end
  end
end
