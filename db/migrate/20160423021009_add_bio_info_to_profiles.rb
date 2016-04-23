class AddBioInfoToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :phone, :string
    add_column :profiles, :displayPhone, :boolean
    add_column :profiles, :birthDate, :date
    add_column :profiles, :gender, :integer
    add_column :profiles, :eligible, :boolean
  end
end
