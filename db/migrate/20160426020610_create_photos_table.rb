class CreatePhotosTable < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :description
      t.attachment :image
      t.integer :gallery_id
      t.timestamps
    end
    add_reference :photos, :galleries, index: true, foreign_key: true
  end
end
