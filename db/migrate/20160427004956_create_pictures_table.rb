class CreatePicturesTable < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.string :description
      t.attachment :image
      t.integer :gallery_id
      t.timestamps
    end
    add_reference :pictures, :galleries, index: true, foreign_key: true
  end
end