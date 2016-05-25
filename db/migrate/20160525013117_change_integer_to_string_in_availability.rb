class ChangeIntegerToStringInAvailability < ActiveRecord::Migration
  def change
    change_column :availability, :start_at, :string
    change_column :availability, :end_at, :string
  end
end
