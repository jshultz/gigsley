class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :street
      t.string :city
      t.string :state
      t.string :home_phone
      t.string :mobile_phone
      t.belongs_to :user, index: true

      t.timestamps null: false
    end
  end
end
