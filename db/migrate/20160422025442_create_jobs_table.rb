class CreateJobsTable < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :name
      t.references :profile, index: true, foreign_key: true
    end
  end
end
