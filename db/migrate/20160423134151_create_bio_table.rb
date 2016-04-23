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

      t.belongs_to :profile, index: true
    end
  end
end
