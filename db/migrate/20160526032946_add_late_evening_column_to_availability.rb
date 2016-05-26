class AddLateEveningColumnToAvailability < ActiveRecord::Migration
  def change
    add_column :availability, :lateEvening, :boolean
  end
end
