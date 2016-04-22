class AddTermsColumnToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :terms, :boolean
  end
end
