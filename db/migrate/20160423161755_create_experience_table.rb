class CreateExperienceTable < ActiveRecord::Migration
  def change
    create_table :experiences do |t|
      t.boolean :specialNeeds
      t.boolean :infants
      t.boolean :twins
      t.boolean :homework
      t.boolean :years
      t.boolean :sickChildren

      t.belongs_to :profile, index: true
    end
    add_reference :profiles, :experiences, index: true
  end
end
