class CreateGalleryTable < ActiveRecord::Migration
  def change
    create_table :galleries do |t|
      t.string :name
      t.string :description
      t.integer :cover

      t.timestamps
      t.references :profile, index: true, foreign_key: true
    end
  end
end
