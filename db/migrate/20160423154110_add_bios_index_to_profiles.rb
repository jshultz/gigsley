class AddBiosIndexToProfiles < ActiveRecord::Migration
  def change
    add_reference :profiles, :bios, index: true
  end
end
