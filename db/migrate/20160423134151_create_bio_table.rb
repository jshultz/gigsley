class CreateBioTable < ActiveRecord::Migration
  def change
    create_table :bios do |t|
      t.string :title
      t.string :experience
      t.boolean :car
      t.boolean :pet
      t.boolean :smoke
      t.integer :minHour
      t.integer :maxHour
      t.integer :travel
      t.references :profile, index: true, foreign_key: true
    end

  end
end
