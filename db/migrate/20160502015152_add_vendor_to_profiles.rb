class AddVendorToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :vendor, :boolean
  end
end
