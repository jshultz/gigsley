class CreateExperienceTable < ActiveRecord::Migration
  def change
    create_table :experiences do |t|
      t.boolean :specialNeeds
      t.boolean :infants
      t.boolean :twins
      t.boolean :homework
      t.boolean :years
      t.boolean :sickChildren

      t.references :profile, index: true, foreign_key: true
    end

  end
end
