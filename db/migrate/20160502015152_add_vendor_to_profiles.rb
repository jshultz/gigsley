class AddVendorToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :provider, :boolean
    add_column :profiles, :customer, :boolean
  end
end
