class AddIpAddressAndFullAddressToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :ip, :string
    add_column :profiles, :full_address, :string
  end
end
